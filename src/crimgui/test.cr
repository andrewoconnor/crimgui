require "crsfml"
require "crystal-raw-gl/gl"
require "./lib"

module ImGui
  class SFML
    include SF::Drawable

    property window : SF::RenderWindow
    property target : SF::RenderTarget
    property load_default_font : Bool
    property imgui_context : Void*
    property window_has_focus : Bool
    property mouse_moved : Bool
    property mouse_cursor_loaded : Bool[LibImGui::ImGuiMouseCursor::COUNT]
    property mouse_cursors : SF::Cursor[LibImGui::ImGuiMouseCursor::COUNT]
    property font_texture : SF::Texture
    property font_texture_handle : Int32
    property io : LibImGui::ImGuiIO*?

    def initialize(window : SF::RenderWindow, load_default_font : Bool = true)
      initialize(window, window, load_default_font)
    end

    def initialize(@window : SF::Window, @target : SF::RenderTarget, @load_default_font : Bool)
      @imgui_context = LibImGui.imguicontext_allocate(Pointer(LibImGui::ImFontAtlas).null)
      @mouse_cursor_loaded = uninitialized Bool[LibImGui::ImGuiMouseCursor::COUNT]
      @mouse_cursors = uninitialized SF::Cursor[LibImGui::ImGuiMouseCursor::COUNT]
      @font_texture = SF::Texture.new
      @font_texture_handle = font_texture.native_handle
      @window_has_focus = false
      @mouse_moved = false
    end

    def finalize
      LibImGui.imguicontext_destroy(imgui_context)
    end

    def load_cursor(imgui_cursor, sfml_cursor)
      mouse_cursors[imgui_cursor.value] = SF::Cursor.new
      mouse_cursor_loaded[imgui_cursor.value] = mouse_cursors[imgui_cursor.value].load_from_system(sfml_cursor)
    end

    def update_font_texture(imgui_io = nil)
      imgui_io ||= io

      LibImGui.imfontatlas_get_tex_data_as_rgba32(imgui_io.value.fonts, out pixels, out width, out height, out bytes_per_pixel)

      font_texture.create(width, height)
      font_texture.update(pixels)

      imgui_io.value.fonts.value.tex_id = pointerof(@font_texture_handle).as(Void*) # maybe memcpy?
    end

    def display_size
      window.size
    end

    def focus?
      window_has_focus
    end

    def mouse_moved?
      @mouse_moved
    end

    def new_frame
      LibImGui.new_frame
    end

    def end_frame
      LibImGui.end_frame
    end

    def begin
      LibImGui.begin("crimgui", Pointer(Bool).null, LibImGui::ImGuiWindowFlags::None)
    end

    def end
      LibImGui.end
    end

    def render
      LibImGui.render
    end

    def button(label : String, size : ImVec2 = ImVec2.new(0, 0))
      LibImGui.button(label, size)
    end

    def draw(target : SF::RenderTarget, states : SF::RenderStates)
      draw_data = LibImGui.draw_data
      return if draw_data.null? || draw_data.value.cmd_lists_count == 0
      raise "Uninitialized font texture" if io.value.fonts.value.tex_id.null?
      target.reset_gl_states
      frame_buffer_width = LibC::Int.new(io.value.display_size.x * io.value.display_framebuffer_scale.x)
      frame_buffer_height = LibC::Int.new(io.value.display_size.y * io.value.display_framebuffer_scale.y)
      return if frame_buffer_width == 0 || frame_buffer_height == 0
      LibImGui.imdrawdata_scale_clip_rects(draw_data, io.value.display_framebuffer_scale)

      {% if GL.has_constant?("VERSION_ES_CL_1_1") %}
        GL.get_integerv(GL::TEXTURE_BINDING_2D, out last_texture)
        GL.get_integerv(GL::ARRAY_BUFFER_BINDING, out last_array_buffer)
        GL.get_integerv(GL::ELEMENT_ARRAY_BUFFER_BINDING, out last_element_array_buffer)
      {% else %}
        GL.push_attrib(GL::ENABLE_BIT | GL::COLOR_BUFFER_BIT | GL::TRANSFORM_BIT)
      {% end %}

      GL.enable(GL::BLEND)
      GL.blend_func(GL::SRC_ALPHA, GL::ONE_MINUS_SRC_ALPHA)
      GL.disable(GL::CULL_FACE)
      GL.disable(GL::DEPTH_TEST)
      GL.enable(GL::SCISSOR_TEST)
      GL.enable(GL::TEXTURE_2D)
      GL.disable(GL::LIGHTING)
      GL.enable_client_state(GL::VERTEX_ARRAY)
      GL.enable_client_state(GL::COLOR_ARRAY)
      GL.enable_client_state(GL::TEXTURE_COORD_ARRAY)

      GL.viewport(GL::Int.new(0), GL::Int.new(0), GL::Sizei.new(frame_buffer_width), GL::Sizei.new(frame_buffer_height))

      GL.matrix_mode(GL::TEXTURE)
      GL.load_identity

      GL.matrix_mode(GL::PROJECTION)
      GL.load_identity

      {% if GL.has_constant?("VERSION_ES_CL_1_1") %}
        GL.orthof(0.0_f32, io.value.display_size.x, io.value.display_size.y, 0.0_f32, -1.0, 1.0)
      {% else %}
        GL.ortho(0.0_f32, io.value.display_size.x, io.value.display_size.y, 0.0_f32, -1.0, 1.0)
      {% end %}

      GL.matrix_mode(GL::MODELVIEW)
      GL.load_identity

      (0...draw_data.value.cmd_lists_count).each do |n|
        # puts "cmd_lists_count: #{n}"
        cmd_list = draw_data.value.cmd_lists[n]
        vtx_buffer = cmd_list.value.vtx_buffer.data.as(LibC::UChar*)
        idx_buffer = cmd_list.value.idx_buffer.data.as(LibImGui::ImDrawIdx*)

        # puts cmd_list.value.cmd_buffer
        # puts "idx_buffer: #{idx_buffer.value}"

        GL.vertex_pointer(2, GL::FLOAT, sizeof(LibImGui::ImDrawVert), (vtx_buffer + offsetof(LibImGui::ImDrawVert, @pos)).as(Void*))
        GL.tex_coord_pointer(2, GL::FLOAT, sizeof(LibImGui::ImDrawVert), (vtx_buffer + offsetof(LibImGui::ImDrawVert, @uv)).as(Void*))
        GL.color_pointer(4, GL::UNSIGNED_BYTE, sizeof(LibImGui::ImDrawVert), (vtx_buffer + offsetof(LibImGui::ImDrawVert, @col)).as(Void*))

        (0...cmd_list.value.cmd_buffer.size).each do |cmd_idx|
          # puts "cmd_idx #{cmd_idx}"
          pcmd = cmd_list.value.cmd_buffer.data.as(LibImGui::ImDrawCmd*) + cmd_idx

          puts pcmd.value.clip_rect

          if pcmd.value.user_callback.null?
            GL.bind_texture(GL::TEXTURE_2D, pcmd.value.texture_id.as(GL::Uint*).value)
            GL.scissor(
              GL::Int.new(pcmd.value.clip_rect.x),
              GL::Int.new(frame_buffer_height - pcmd.value.clip_rect.w),
              GL::Sizei.new(pcmd.value.clip_rect.z - pcmd.value.clip_rect.x),
              GL::Sizei.new(pcmd.value.clip_rect.w - pcmd.value.clip_rect.y)
            )
            GL.draw_elements(GL::TRIANGLES, GL::Sizei.new(pcmd.value.elem_count), GL::UNSIGNED_SHORT, idx_buffer)
          else
            # TODO handle callback
          end

          idx_buffer = idx_buffer + pcmd.value.elem_count
        end
      end

      {% if GL.has_constant?("VERSION_ES_CL_1_1") %}
        GL.bind_texture(GL::TEXTURE_2D, last_texture)
        GL.bind_buffer(GL::ARRAY_BUFFER, last_array_buffer)
        GL.bind_buffer(GL::ELEMENT_ARRAY_BUFFER, last_element_array_buffer)
        GL.disable(GL::SCISSOR_TEST)
      {% else %}
        GL.pop_attrib
      {% end %}
    end

    def update(dt)
      update_mouse_cursor
      io.value.delta_time = LibC::Float.new(dt)
      io.value.mouse_pos = ImVec2.new(SF::Mouse.get_position(window))
    end

    def update_mouse_cursor
      return unless io.value.config_flags.value & LibImGui::ImGuiConfigFlags::NoMouseCursorChange.value == 0
      cursor = LibImGui.mouse_cursor
      if io.value.mouse_draw_cursor || cursor == LibImGui::ImGuiMouseCursor::None.value
        window.mouse_cursor_visible = false
      else
        window.mouse_cursor_visible = true
        window.mouse_cursor = mouse_cursor_loaded[cursor.value] ? mouse_cursors[cursor.value] : mouse_cursors[LibImGui::ImGuiMouseCursor::Arrow.value]
      end
    end

    def io : LibImGui::ImGuiIO*
      @io ||= LibImGui.io.tap do |i|
        # init supported features
        i.value.backend_platform_name = "crimgui_sfml"
        i.value.backend_flags = LibImGui::ImGuiBackendFlags::HasMouseCursors | LibImGui::ImGuiBackendFlags::HasSetMousePos

        i.value.config_flags = LibImGui::ImGuiConfigFlags::NavEnableKeyboard | LibImGui::ImGuiConfigFlags::NavEnableSetMousePos

        # init keyboard mapping
        i.value.key_map[LibImGui::ImGuiKey::Tab.value] = SF::Keyboard::Key::Tab.value
        i.value.key_map[LibImGui::ImGuiKey::LeftArrow.value] = SF::Keyboard::Key::Left.value
        i.value.key_map[LibImGui::ImGuiKey::RightArrow.value] = SF::Keyboard::Key::Right.value
        i.value.key_map[LibImGui::ImGuiKey::UpArrow.value] = SF::Keyboard::Key::Up.value
        i.value.key_map[LibImGui::ImGuiKey::DownArrow.value] = SF::Keyboard::Key::Down.value
        i.value.key_map[LibImGui::ImGuiKey::PageUp.value] = SF::Keyboard::Key::PageUp.value
        i.value.key_map[LibImGui::ImGuiKey::PageDown.value] = SF::Keyboard::Key::PageDown.value
        i.value.key_map[LibImGui::ImGuiKey::Home.value] = SF::Keyboard::Key::Home.value
        i.value.key_map[LibImGui::ImGuiKey::End.value] = SF::Keyboard::Key::End.value
        i.value.key_map[LibImGui::ImGuiKey::Insert.value] = SF::Keyboard::Key::Insert.value
        {% if flag?(:android) %}
          i.value.key_map[LibImGui::ImGuiKey::Backspace.value] = SF::Keyboard::Key::Delete.value
        {% else %}
          i.value.key_map[LibImGui::ImGuiKey::Delete.value] = SF::Keyboard::Key::Delete.value
          i.value.key_map[LibImGui::ImGuiKey::Backspace.value] = SF::Keyboard::Key::Backspace.value
        {% end %}
        i.value.key_map[LibImGui::ImGuiKey::Space.value] = SF::Keyboard::Key::Space.value
        i.value.key_map[LibImGui::ImGuiKey::Enter.value] = SF::Keyboard::Key::Enter.value
        i.value.key_map[LibImGui::ImGuiKey::Escape.value] = SF::Keyboard::Key::Escape.value
        i.value.key_map[LibImGui::ImGuiKey::A.value] = SF::Keyboard::Key::A.value
        i.value.key_map[LibImGui::ImGuiKey::C.value] = SF::Keyboard::Key::C.value
        i.value.key_map[LibImGui::ImGuiKey::V.value] = SF::Keyboard::Key::V.value
        i.value.key_map[LibImGui::ImGuiKey::X.value] = SF::Keyboard::Key::X.value
        i.value.key_map[LibImGui::ImGuiKey::Y.value] = SF::Keyboard::Key::Y.value
        i.value.key_map[LibImGui::ImGuiKey::Z.value] = SF::Keyboard::Key::Z.value

        # TODO: init joystick mapping

        # init rendering
        i.value.display_size = ImVec2.new(target.size)

        # TODO: init clipboard

        # init cursors
        (0...LibImGui::ImGuiMouseCursor::COUNT.value).each do |i|
          mouse_cursor_loaded[i] = false
        end

        load_cursor(LibImGui::ImGuiMouseCursor::Arrow, SF::Cursor::Arrow)
        load_cursor(LibImGui::ImGuiMouseCursor::TextInput, SF::Cursor::Text)
        load_cursor(LibImGui::ImGuiMouseCursor::ResizeAll, SF::Cursor::SizeAll)
        load_cursor(LibImGui::ImGuiMouseCursor::ResizeNS, SF::Cursor::SizeVertical)
        load_cursor(LibImGui::ImGuiMouseCursor::ResizeEW, SF::Cursor::SizeHorizontal)
        load_cursor(LibImGui::ImGuiMouseCursor::ResizeNESW, SF::Cursor::SizeBottomLeftTopRight)
        load_cursor(LibImGui::ImGuiMouseCursor::ResizeNWSE, SF::Cursor::SizeTopLeftBottomRight)
        load_cursor(LibImGui::ImGuiMouseCursor::Hand, SF::Cursor::Hand)

        @font_texture = SF::Texture.new
        @font_texture_handle = font_texture.native_handle
        update_font_texture(i) if load_default_font

        window_has_focus = window.focus?
      end
    end
  end
end

mode = SF::VideoMode.new(1920, 1080)

window = SF::RenderWindow
  .new(mode, "orb")
  .tap { |w|
    w.vertical_sync_enabled = true
  }.as(SF::RenderWindow)

clock = SF::Clock.new

imgui = ImGui::SFML.new(window)

puts String.new(imgui.io.value.backend_platform_name)
puts imgui.io.value.backend_flags
puts imgui.io.value.config_flags
puts imgui.io.value.key_map
puts imgui.io.value.display_size
puts imgui.io.value.display_framebuffer_scale
puts imgui.mouse_cursor_loaded
puts imgui.io.value.fonts.value.tex_id

while window.open?
  while event = window.poll_event
    case event
    when SF::Event::Closed
      window.close
    when SF::Event::KeyPressed
      window.close if event.code == SF::Keyboard::Escape
    end
  end

  imgui.update(clock.restart.as_seconds)
  # puts imgui.io.value.delta_time
  # puts imgui.io.value.mouse_pos
  imgui.new_frame
  imgui.begin
  imgui.button("Test")
  imgui.end
  imgui.end_frame
  imgui.render

  window.clear
  window.draw(imgui)
  window.display
end
