require "crsfml"
require "crystal-raw-gl/gl"
require "./lib2"

module OpenGL
  def draw(*args)
    io = LibImGui.ig_get_io
    draw_data = LibImGui.ig_get_draw_data
    return if draw_data.null? || draw_data.value.cmd_lists_count == 0
    raise "Uninitialized font texture" if io.value.fonts.value.tex_id.null?
    # target.reset_gl_states
    frame_buffer_width = LibC::Int.new(io.value.display_size.x * io.value.display_framebuffer_scale.x)
    frame_buffer_height = LibC::Int.new(io.value.display_size.y * io.value.display_framebuffer_scale.y)
    return if frame_buffer_width == 0 || frame_buffer_height == 0
    LibImGui.im_draw_data_scale_clip_rects(draw_data, io.value.display_framebuffer_scale)

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

    GL.viewport(
      GL::Int.new(0),
      GL::Int.new(0),
      GL::Sizei.new(frame_buffer_width),
      GL::Sizei.new(frame_buffer_height)
    )

    GL.matrix_mode(GL::TEXTURE)
    GL.load_identity

    GL.matrix_mode(GL::PROJECTION)
    GL.load_identity

    {% if GL.has_constant?("VERSION_ES_CL_1_1") %}
      GL.orthof(
        GL::Double.new(0),
        GL::Double.new(io.value.display_size.x / io.value.display_framebuffer_scale.x),
        GL::Double.new(io.value.display_size.y / io.value.display_framebuffer_scale.y),
        GL::Double.new(0),
        GL::Double.new(-1),
        GL::Double.new(1)
      )
    {% else %}
      GL.ortho(
        GL::Double.new(0),
        GL::Double.new(io.value.display_size.x / io.value.display_framebuffer_scale.x),
        GL::Double.new(io.value.display_size.y / io.value.display_framebuffer_scale.y),
        GL::Double.new(0),
        GL::Double.new(-1),
        GL::Double.new(1)
      )
    {% end %}

    GL.matrix_mode(GL::MODELVIEW)
    GL.load_identity

    (0...draw_data.value.cmd_lists_count).each do |n|
      cmd_list = draw_data.value.cmd_lists[n]
      vtx_buffer = cmd_list.value.vtx_buffer.data.as(LibC::UChar*)
      idx_buffer = cmd_list.value.idx_buffer.data.as(LibImGui::ImDrawIdx*)

      GL.vertex_pointer(2, GL::FLOAT, sizeof(LibImGui::ImDrawVert), (vtx_buffer + offsetof(LibImGui::ImDrawVert, @pos)).as(Void*))
      GL.tex_coord_pointer(2, GL::FLOAT, sizeof(LibImGui::ImDrawVert), (vtx_buffer + offsetof(LibImGui::ImDrawVert, @uv)).as(Void*))
      GL.color_pointer(4, GL::UNSIGNED_BYTE, sizeof(LibImGui::ImDrawVert), (vtx_buffer + offsetof(LibImGui::ImDrawVert, @col)).as(Void*))

      (0...cmd_list.value.cmd_buffer.size).each do |cmd_idx|
        pcmd = cmd_list.value.cmd_buffer.data.as(LibImGui::ImDrawCmd*) + cmd_idx

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
end

module SFML
  macro included
    include SF::Drawable
  end

  property window : SF::RenderWindow
  property target : SF::RenderTarget
  property load_default_font : Bool
  property imgui_context : Void*
  property window_has_focus : Bool
  property mouse_moved : Bool
  property mouse_btn_pressed : Bool[5]
  property mouse_cursor_loaded : Bool[LibImGui::ImGuiMouseCursor::COUNT]
  property mouse_cursors : SF::Cursor[LibImGui::ImGuiMouseCursor::COUNT]
  property font_texture : SF::Texture
  property font_texture_handle : LibC::UInt
  property io : LibImGui::ImGuiIO*?

  def initialize(window : SF::RenderWindow, load_default_font : Bool = true)
    initialize(window, window, load_default_font)
  end

  def initialize(@window : SF::Window, @target : SF::RenderTarget, @load_default_font : Bool)
    @imgui_context = LibImGui.ig_create_context(Pointer(LibImGui::ImFontAtlas).null)
    # @io = Pointer(LibImGui::ImGuiIO).null
    @mouse_cursor_loaded = uninitialized Bool[LibImGui::ImGuiMouseCursor::COUNT]
    @mouse_cursors = uninitialized SF::Cursor[LibImGui::ImGuiMouseCursor::COUNT]
    @font_texture = SF::Texture.new
    @font_texture_handle = LibC::UInt.new(font_texture.native_handle)
    @window_has_focus = false
    @mouse_moved = false
    @mouse_btn_pressed = StaticArray(Bool, 5).new(false)
    init_io
  end

  def finalize
    LibImGui.ig_destroy_context(imgui_context)
  end

  def load_cursor(imgui_cursor, sfml_cursor)
    mouse_cursors[imgui_cursor.value] = SF::Cursor.new
    mouse_cursor_loaded[imgui_cursor.value] = mouse_cursors[imgui_cursor.value].load_from_system(sfml_cursor)
  end

  def update_font_texture
    io = LibImGui.ig_get_io
    LibImGui.im_font_atlas_get_tex_data_as_rgba32(io.value.fonts, out pixels, out width, out height, out bytes_per_pixel)

    font_texture.create(width, height)
    font_texture.update(pixels)

    @font_texture_handle = LibC::UInt.new(font_texture.native_handle)

    io.value.fonts.value.tex_id = pointerof(@font_texture_handle).as(Void*)
  end

  def display_size
    window.size
  end

  def focus?
    window_has_focus
  end

  def mouse_moved?
    mouse_moved
  end

  def draw(target : SF::RenderTarget, states : SF::RenderStates)
    super
  end

  def render
    target.reset_gl_states
    super
  end

  def update(dt)
    io = LibImGui.ig_get_io
    update_mouse_cursor
    io.value.display_size = ImVec2.new(target.size)
    io.value.delta_time = LibC::Float.new(dt)
    # return unless window.focus?
    if io.value.want_set_mouse_pos
      SF::Mouse.position = SF::Vector2.new(io.value.mouse_pos.x, io.value.mouse_pos.y)
    else
      io.value.mouse_pos = ImVec2.new(SF::Mouse.get_position(window))
    end

    (0..2).each do |mouse_btn|
      io.value.mouse_down[mouse_btn] = mouse_btn_pressed[mouse_btn] || SF::Mouse.button_pressed?(SF::Mouse::Button.new(mouse_btn))
      mouse_btn_pressed[mouse_btn] = false
    end

    window.mouse_cursor_visible = false if io.value.mouse_draw_cursor

    io.value.keys_down.each_with_index do |_, idx|
      io.value.keys_down[idx] = false
      if idx < SF::Keyboard::Key::KeyCount.value && idx != SF::Keyboard::Key::Enter.value
        key = SF::Keyboard::Key.new(idx)
        io.value.keys_down[idx] = SF::Keyboard.key_pressed?(key)
      end
    end

    io.value.key_ctrl = io.value.keys_down[SF::Keyboard::Key::LControl.value] || io.value.keys_down[SF::Keyboard::Key::RControl.value]
    io.value.key_shift = io.value.keys_down[SF::Keyboard::Key::LAlt.value] || io.value.keys_down[SF::Keyboard::Key::RAlt.value]
    io.value.key_alt = io.value.keys_down[SF::Keyboard::Key::LShift.value] || io.value.keys_down[SF::Keyboard::Key::RShift.value]
    io.value.key_super = io.value.keys_down[SF::Keyboard::Key::LSystem.value] || io.value.keys_down[SF::Keyboard::Key::RSystem.value]
  end

  def process_event(event)
    io = LibImGui.ig_get_io
    # return unless window.focus?
    case event
    when SF::Event::MouseMoved
      @mouse_moved = true
    when SF::Event::MouseButtonPressed
    when SF::Event::MouseButtonReleased
      mouse_btn_pressed[event.button.value] = true if (0..2).includes?(event.button.value)
    when SF::Event::TextEntered
      LibImGui.im_gui_io_add_input_characters_utf8(io, event.unicode.unsafe_chr.to_s) unless [58, 127].includes?(event.unicode)
    when SF::Event::LostFocus
      @window_has_focus = false
    when SF::Event::GainedFocus
      @window_has_focus = true
    end
  end

  def update_mouse_cursor
    io = LibImGui.ig_get_io
    return unless (io.value.config_flags.value & LibImGui::ImGuiConfigFlags::NoMouseCursorChange.value) == 0
    cursor = LibImGui.ig_get_mouse_cursor
    if io.value.mouse_draw_cursor || cursor == LibImGui::ImGuiMouseCursor::None.value
      window.mouse_cursor_visible = false
    else
      window.mouse_cursor_visible = true
      window.mouse_cursor = mouse_cursor_loaded[cursor.value] ? mouse_cursors[cursor.value] : mouse_cursors[LibImGui::ImGuiMouseCursor::Arrow.value]
    end
  end

  def set_clipboard_text
    ->(user_data : Void*, text : LibC::Char*) { SF::Clipboard.string = String.new(text) }
  end

  def get_clipboard_text
    ->(user_data : Void*) { SF::Clipboard.string.to_unsafe }
  end

  def init_io
    # init supported features
    LibImGui.ig_get_io.value.backend_platform_name = "crimgui_sfml"
    LibImGui.ig_get_io.value.backend_flags = LibImGui::ImGuiBackendFlags::HasMouseCursors | LibImGui::ImGuiBackendFlags::HasSetMousePos

    # LibImGui.ig_get_io.value.config_flags = LibImGui::ImGuiConfigFlags::NavEnableKeyboard | LibImGui::ImGuiConfigFlags::NavEnableSetMousePos

    # init keyboard mapping
    LibImGui.ig_get_io.value.key_map[LibImGui::ImGuiKey::Tab.value] = SF::Keyboard::Key::Tab.value
    LibImGui.ig_get_io.value.key_map[LibImGui::ImGuiKey::LeftArrow.value] = SF::Keyboard::Key::Left.value
    LibImGui.ig_get_io.value.key_map[LibImGui::ImGuiKey::RightArrow.value] = SF::Keyboard::Key::Right.value
    LibImGui.ig_get_io.value.key_map[LibImGui::ImGuiKey::UpArrow.value] = SF::Keyboard::Key::Up.value
    LibImGui.ig_get_io.value.key_map[LibImGui::ImGuiKey::DownArrow.value] = SF::Keyboard::Key::Down.value
    LibImGui.ig_get_io.value.key_map[LibImGui::ImGuiKey::PageUp.value] = SF::Keyboard::Key::PageUp.value
    LibImGui.ig_get_io.value.key_map[LibImGui::ImGuiKey::PageDown.value] = SF::Keyboard::Key::PageDown.value
    LibImGui.ig_get_io.value.key_map[LibImGui::ImGuiKey::Home.value] = SF::Keyboard::Key::Home.value
    LibImGui.ig_get_io.value.key_map[LibImGui::ImGuiKey::End.value] = SF::Keyboard::Key::End.value
    LibImGui.ig_get_io.value.key_map[LibImGui::ImGuiKey::Insert.value] = SF::Keyboard::Key::Insert.value
    {% if flag?(:android) %}
      LibImGui.ig_get_io.value.key_map[LibImGui::ImGuiKey::Backspace.value] = SF::Keyboard::Key::Delete.value
    {% else %}
      LibImGui.ig_get_io.value.key_map[LibImGui::ImGuiKey::Delete.value] = SF::Keyboard::Key::Delete.value
      LibImGui.ig_get_io.value.key_map[LibImGui::ImGuiKey::Backspace.value] = SF::Keyboard::Key::Backspace.value
    {% end %}
    LibImGui.ig_get_io.value.key_map[LibImGui::ImGuiKey::Space.value] = SF::Keyboard::Key::Space.value
    LibImGui.ig_get_io.value.key_map[LibImGui::ImGuiKey::Enter.value] = SF::Keyboard::Key::Enter.value
    LibImGui.ig_get_io.value.key_map[LibImGui::ImGuiKey::Escape.value] = SF::Keyboard::Key::Escape.value
    LibImGui.ig_get_io.value.key_map[LibImGui::ImGuiKey::A.value] = SF::Keyboard::Key::A.value
    LibImGui.ig_get_io.value.key_map[LibImGui::ImGuiKey::C.value] = SF::Keyboard::Key::C.value
    LibImGui.ig_get_io.value.key_map[LibImGui::ImGuiKey::V.value] = SF::Keyboard::Key::V.value
    LibImGui.ig_get_io.value.key_map[LibImGui::ImGuiKey::X.value] = SF::Keyboard::Key::X.value
    LibImGui.ig_get_io.value.key_map[LibImGui::ImGuiKey::Y.value] = SF::Keyboard::Key::Y.value
    LibImGui.ig_get_io.value.key_map[LibImGui::ImGuiKey::Z.value] = SF::Keyboard::Key::Z.value

    # TODO: init joystick mapping

    # init rendering
    LibImGui.ig_get_io.value.display_size = ImVec2.new(target.size)

    # init clipboard
    LibImGui.ig_get_io.value.set_clipboard_text_fn = set_clipboard_text
    LibImGui.ig_get_io.value.get_clipboard_text_fn = get_clipboard_text

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

    update_font_texture if load_default_font

    @window_has_focus = window.focus?
  end
end

class ImGui
  include OpenGL
  include SFML

  def new_frame
    LibImGui.ig_new_frame
  end

  def end_frame
    LibImGui.ig_end_frame
  end

  def begin(
    name : String = "crimgui",
    p_open : Bool* = Pointer(Bool).null,
    flags : LibImGui::ImGuiWindowFlags = LibImGui::ImGuiWindowFlags::None
  )
    LibImGui.ig_begin(name, p_open, flags)
  end

  def end
    LibImGui.ig_end
  end

  def show_demo_window(p_open : Bool* = Pointer(Bool).null)
    LibImGui.ig_show_demo_window(p_open)
  end

  def show_metrics_window(p_open : Bool* = Pointer(Bool).null)
    LibImGui.ig_show_metrics_window(p_open)
  end

  def button(label : String, size : ImVec2 = ImVec2.new(0, 0))
    LibImGui.ig_button(label, size)
  end

  def text(fmt : String)
    LibImGui.ig_text(fmt)
  end

  def render
    LibImGui.ig_render
  end
end

mode = SF::VideoMode.new(1920, 1080)

window = SF::RenderWindow
  .new(mode, "orb")
  .tap { |w|
    w.vertical_sync_enabled = true
  }.as(SF::RenderWindow)

rectangle = SF::RectangleShape.new
rectangle.size = SF.vector2f(44, 34)
rectangle.outline_color = SF::Color::Red
rectangle.outline_thickness = 5
rectangle.position = {64, 79}

clock = SF::Clock.new

imgui = ImGui.new(window)

# puts String.new(imgui.io.value.backend_platform_name)
# puts imgui.io.value.backend_flags
# puts imgui.io.value.config_flags
# puts imgui.io.value.key_map
# puts imgui.io.value.display_size
# puts imgui.io.value.display_framebuffer_scale
# puts imgui.mouse_cursor_loaded
# puts imgui.io.value.fonts.value.tex_id

# puts LibImGui.ig_get_io.value.key_map

while window.open?
  while event = window.poll_event
    imgui.process_event(event)
    case event
    when SF::Event::Closed
      window.close
    when SF::Event::KeyPressed
      window.close if event.code == SF::Keyboard::Escape
    end
  end

  imgui.update(clock.restart.as_seconds)

  imgui.new_frame

  imgui.show_demo_window

  # LibImGui.show_user_guide

  # LibImGui.show_metrics_window(Pointer(Bool).null)

  # imgui.begin

  # LibImGui.set_window_size_str("crimgui", ImVec2.new(250, 150), LibImGui::ImGuiCond::Always)
  # if imgui.button("Test", ImVec2.new(100, 50))
  #   puts "clicked!"
  # end

  # imgui.end
  imgui.end_frame

  window.clear
  imgui.render
  window.draw(imgui)
  window.display
end
