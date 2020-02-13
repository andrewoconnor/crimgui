require "crsfml"
require "crystal-raw-gl/gl"
require "./lib"

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

        if pcmd.value.user_callback_data.null?
          GL.bind_texture(GL::TEXTURE_2D, pcmd.value.texture_id.as(GL::Uint*).value)
          GL.scissor(
            GL::Int.new(pcmd.value.clip_rect.x),
            GL::Int.new(frame_buffer_height - pcmd.value.clip_rect.w),
            GL::Sizei.new(pcmd.value.clip_rect.z - pcmd.value.clip_rect.x),
            GL::Sizei.new(pcmd.value.clip_rect.w - pcmd.value.clip_rect.y)
          )
          GL.draw_elements(GL::TRIANGLES, GL::Sizei.new(pcmd.value.elem_count), GL::UNSIGNED_SHORT, idx_buffer)
        else
          pcmd.value.user_callback.call(cmd_list, pcmd)
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
  property font_texture_handle : GL::Uint
  property textures : Hash(Int32, Array(GL::Uint))
  property animations : Hash(Int32, Array(Int32))

  property io : LibImGui::ImGuiIO*?

  def initialize(window : SF::RenderWindow, load_default_font : Bool = true)
    initialize(window, window, load_default_font)
  end

  def initialize(@window : SF::Window, @target : SF::RenderTarget, @load_default_font : Bool)
    @imgui_context = LibImGui.ig_create_context(Pointer(LibImGui::ImFontAtlas).null)
    # @io = Pointer(LibImGui::ImGuiIO).null
    @mouse_cursor_loaded = StaticArray(Bool, LibImGui::ImGuiMouseCursor::COUNT).new(false)
    @mouse_cursors = uninitialized SF::Cursor[LibImGui::ImGuiMouseCursor::COUNT]
    @font_texture = SF::Texture.new
    @font_texture_handle = GL::Uint.new(font_texture.native_handle)
    @textures = {} of Int32 => Array(GL::Uint)
    @animations = {} of Int32 => Array(Int32)
    @window_has_focus = false
    @mouse_moved = false
    @mouse_btn_pressed = StaticArray(Bool, 5).new(false)
    init_io
  end

  def finalize
    LibImGui.ig_destroy_context(imgui_context)
  end

  macro load_cursor(imgui_cursor, sfml_cursor = nil)
    {% imgui_enum = "LibImGui::ImGuiMouseCursor::" + imgui_cursor %}
    {% sfml_enum = "SF::Cursor::" + (sfml_cursor || imgui_cursor) %}
    mouse_cursors[{{imgui_enum.id}}.value] = SF::Cursor.new
    mouse_cursor_loaded[{{imgui_enum.id}}.value] = mouse_cursors[{{imgui_enum.id}}.value].load_from_system({{sfml_enum.id}})
  end

  def update_font_texture
    io = LibImGui.ig_get_io
    LibImGui.im_font_atlas_get_tex_data_as_rgba32(io.value.fonts, out pixels, out width, out height, out bytes_per_pixel)

    font_texture.create(width, height)
    font_texture.update(pixels)

    @font_texture_handle = GL::Uint.new(font_texture.native_handle)

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
    target.reset_gl_states
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
    when SF::Event::MouseWheelScrolled
      io.value.mouse_wheel = event.delta if event.delta.abs > 0.5
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

  macro map_key(io, imgui_key, sfml_key = nil)
    {% imgui_enum = "LibImGui::ImGuiKey::" + imgui_key %}
    {% sfml_enum = "SF::Keyboard::Key::" + (sfml_key || imgui_key) %}
    io.value.key_map[{{imgui_enum.id}}.value] = {{sfml_enum.id}}.value
  end

  def init_io
    io = LibImGui.ig_get_io
    # init supported features
    io.value.backend_platform_name = "crimgui_sfml"
    io.value.backend_flags = LibImGui::ImGuiBackendFlags::HasMouseCursors | LibImGui::ImGuiBackendFlags::HasSetMousePos

    # io.value.config_flags = LibImGui::ImGuiConfigFlags::NavEnableKeyboard | LibImGui::ImGuiConfigFlags::NavEnableSetMousePos

    # init keyboard mapping
    map_key(io, "Tab")
    map_key(io, "LeftArrow", "Left")
    map_key(io, "RightArrow", "Right")
    map_key(io, "UpArrow", "Up")
    map_key(io, "DownArrow", "Down")
    map_key(io, "PageUp")
    map_key(io, "PageDown")
    map_key(io, "Home")
    map_key(io, "End")
    map_key(io, "Insert")
    {% if flag?(:android) %}
      map_key(io, "Backspace", "Delete")
    {% else %}
      map_key(io, "Delete")
      map_key(io, "Backspace")
    {% end %}
    map_key(io, "Space")
    map_key(io, "Enter")
    map_key(io, "Escape")
    map_key(io, "A")
    map_key(io, "C")
    map_key(io, "V")
    map_key(io, "X")
    map_key(io, "Y")
    map_key(io, "Z")

    # TODO: init joystick mapping

    # init rendering
    io.value.display_size = ImVec2.new(target.size)

    # init clipboard
    io.value.set_clipboard_text_fn = set_clipboard_text
    io.value.get_clipboard_text_fn = get_clipboard_text

    # init cursors
    (0...LibImGui::ImGuiMouseCursor::COUNT.value).each do |i|
      mouse_cursor_loaded[i] = false
    end

    load_cursor("Arrow")
    load_cursor("TextInput", "Text")
    load_cursor("ResizeAll", "SizeAll")
    load_cursor("ResizeNS", "SizeVertical")
    load_cursor("ResizeEW", "SizeHorizontal")
    load_cursor("ResizeNESW", "SizeBottomLeftTopRight")
    load_cursor("ResizeNWSE", "SizeTopLeftBottomRight")
    load_cursor("Hand")

    update_font_texture if load_default_font

    @window_has_focus = window.focus?
  end

  def draw_line(a : SF::Vector2, b : SF::Vector2, color : SF::Color, thickness : Float32)
    draw_list = LibImGui.ig_get_window_draw_list
    pos = screen_cursor_pos
    a = ImVec2.new(a.x + pos.x, a.y + pos.y)
    b = ImVec2.new(b.x + pos.x, b.y + pos.y)
    LibImGui.im_draw_list_add_line(draw_list, a, b, 0xffffffff, thickness)
  end

  def draw_animation(animation : Animation)
    @animations[animation.id] = [1] unless animations.has_key?(animation.id)
    frame = @animations[animation.id][0] - 1
    ratio = 1.0 / animation.num_frames
    uv_a = ImVec2.new(ratio * frame, 0.0)
    uv_b = ImVec2.new(ratio * frame + ratio, 0.0)
    uv_c = ImVec2.new(ratio * frame + ratio, 1.0)
    uv_d = ImVec2.new(ratio * frame, 1.0)
    if slider_int("slider_int1", @animations[animation.id].to_unsafe, 1, animation.num_frames)
      frame = @animations[animation.id][0] - 1
      uv_a = ImVec2.new(ratio * frame, 0.0)
      uv_b = ImVec2.new(ratio * frame + ratio, 0.0)
      uv_c = ImVec2.new(ratio * frame + ratio, 1.0)
      uv_d = ImVec2.new(ratio * frame, 1.0)
    end
    draw_texture(animation.texture, animation.texture_size, uv_a, uv_b, uv_c, uv_d)
  end

  def draw_texture(
    texture : SF::Texture,
    texture_size : SF::Vector2i = texture.size,
    uv_a : ImVec2 = ImVec2.new(0.0, 0.0),
    uv_b : ImVec2 = ImVec2.new(1.0, 0.0),
    uv_c : ImVec2 = ImVec2.new(1.0, 1.0),
    uv_d : ImVec2 = ImVec2.new(0.0, 1.0)
  )
    draw_list = LibImGui.ig_get_window_draw_list
    pos = screen_cursor_pos

    @textures[texture.native_handle] = [GL::Uint.new(texture.native_handle)] unless textures.has_key?(texture.native_handle)

    a = ImVec2.new(pos.x, pos.y)
    b = ImVec2.new(pos.x + texture_size.x, pos.y)
    c = ImVec2.new(pos.x + texture_size.x, pos.y + texture_size.y)
    d = ImVec2.new(pos.x, pos.y + texture_size.y)

    # uv_a = ImVec2.new(0.0, 0.0)
    # uv_b = ImVec2.new(1.0, 0.0)
    # uv_c = ImVec2.new(1.0, 1.0)
    # uv_d = ImVec2.new(0.0, 1.0)

    transparent = ImVec4.new(0, 0, 0, 0)
    white = ImVec4.new(1, 1, 1, 1) # 0xffffffff
    col = LibImGui.ig_color_convert_float4_to_u32(white)

    io = LibImGui.ig_get_io
    fonts = io.value.fonts.value
    ptr = fonts.tex_id
    width = Float32.new(fonts.tex_width)
    height = Float32.new(fonts.tex_height)

    LibImGui.im_draw_list_add_image_quad(draw_list, @textures[texture.native_handle].to_unsafe, a, b, c, d, uv_a, uv_b, uv_c, uv_d, col) unless @textures.empty?
    LibImGui.ig_dummy(ImVec2.new(texture_size.x, texture_size.y))
  end
end

module Orb
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

  def show_user_guide
    LibImGui.ig_show_user_guide
  end

  def set_next_window_size(size : ImVec2, cond : LibImGui::ImGuiCond = LibImGui::ImGuiCond::Always)
    LibImGui.ig_set_next_window_size(size, cond)
  end

  def set_window_size(*, name : String, size : ImVec2, cond : LibImGui::ImGuiCond = LibImGui::ImGuiCond::Always)
    LibImGui.ig_set_window_size_str(name, size, cond)
  end

  def set_window_size(*, size : ImVec2, cond : LibImGui::ImGuiCond = LibImGui::ImGuiCond::Always)
    LibImGui.ig_set_window_size_vec2(size, cond)
  end

  def button(label : String, size : ImVec2)
    LibImGui.ig_button(label, size)
  end

  def text(fmt : String)
    LibImGui.ig_text(fmt)
  end

  def text_disabled(fmt : String)
    LibImGui.ig_text_disabled(fmt)
  end

  def text_unformatted(text : String, text_end : String | LibC::Char* = Pointer(LibC::Char).null)
    LibImGui.ig_text_unformatted(text, text_end)
  end

  def bullet_text(fmt : String)
    LibImGui.ig_bullet_text(fmt)
  end

  def item_hovered?(flags : LibImGui::ImGuiHoveredFlags = LibImGui::ImGuiHoveredFlags::None)
    LibImGui.ig_is_item_hovered(flags)
  end

  def align_text_to_frame_padding
    LibImGui.ig_align_text_to_frame_padding
  end

  def begin_tooltip
    LibImGui.ig_begin_tooltip
  end

  def end_tooltip
    LibImGui.ig_end_tooltip
  end

  def render
    LibImGui.ig_render
  end

  def font_config
    LibImGui.im_font_config_im_font_config
  end

  def add_font_from_file_ttf(
    filename : String,
    size_pixels : LibC::Float,
    font_cfg : LibImGui::ImFontConfig* = Pointer(LibImGui::ImFontConfig).null,
    glyph_ranges : LibImGui::ImWchar* = Pointer(LibImGui::ImWchar).null
  )
    io = LibImGui.ig_get_io
    LibImGui.im_font_atlas_add_font_from_file_ttf(io.value.fonts, filename, size_pixels, font_cfg, glyph_ranges)
  end

  def font_atlas_clear
    io = LibImGui.ig_get_io
    LibImGui.im_font_atlas_clear(io.value.fonts)
  end

  def push_id(id : String | Pointer | LibC::Int)
    case id
    when String
      LibImGui.ig_push_id_str(id)
    when Pointer
      LibImGui.ig_push_id_ptr(id)
    when Int
      LibImGui.ig_push_id_int(id)
    end
  end

  def pop_id
    LibImGui.ig_pop_id
  end

  def push_style_var(idx : LibImGui::ImGuiStyleVar, val : LibC::Float | ImVec2)
    case val
    when Float
      LibImGui.ig_push_style_var_float(idx, val)
    when ImVec2
      LibImGui.ig_push_style_var_vec2(idx, val)
    end
  end

  def pop_style_var(count : LibC::Int = 1)
    LibImGui.ig_pop_style_var(count)
  end

  def separator
    LibImGui.ig_separator
  end

  def tree_node(label : String, fmt : String = nil)
    if fmt.nil?
      LibImGui.ig_tree_node_str(label)
    else
      LibImGui.ig_tree_node_str_str(label, fmt)
    end
  end

  def tree_node(ptr_id : Void*, fmt : String)
    LibImGui.ig_tree_node_ptr(ptr_id, fmt)
  end

  def tree_node_ex(
    label : String,
    flags : LibImGui::ImGuiTreeNodeFlags = LibImGui::ImGuiTreeNodeFlags::None,
    fmt : String = nil
  )
    if fmt.nil?
      LibImGui.ig_tree_node_ex_str(label, flags)
    else
      LibImGui.ig_tree_node_ex_str_str(label, flags, fmt)
    end
  end

  def tree_pop
    LibImGui.ig_tree_pop
  end

  def columns(count : Int = 1, id : String | LibC::Char* = Pointer(LibC::Char).null, border : Bool = true)
    LibImGui.ig_columns(count, id, border)
  end

  def next_column
    LibImGui.ig_next_column
  end

  def checkbox(label : String, v : Bool*)
    LibImGui.ig_checkbox(label, v)
  end

  def combo(label : String, current_item : LibC::Int*, items : Array(String), popup_max_height_in_items : Int32 = 3)
    LibImGui.ig_combo(label, current_item, items.map(&.to_unsafe), items.size, popup_max_height_in_items)
  end

  def input_float(
    label : String,
    v : LibC::Float*,
    step : LibC::Float = 0.0,
    step_fast : LibC::Float = 0.0,
    format : String = "%.3f",
    flags : LibImGui::ImGuiInputTextFlags = LibImGui::ImGuiInputTextFlags::None
  )
    LibImGui.ig_input_float(label, v, step, step_fast, format, flags)
  end

  def input_int(
    label : String,
    v : LibC::Int*,
    step : LibC::Int = 1,
    step_fast : LibC::Int = 100,
    flags : LibImGui::ImGuiInputTextFlags = LibImGui::ImGuiInputTextFlags::None
  )
    LibImGui.ig_input_int(label, v, step, step_fast, flags)
  end

  def slider_int(
    label : String,
    v : LibC::Int*,
    min : LibC::Int,
    max : LibC::Int,
    format : String = "%d"
  )
    LibImGui.ig_slider_int(label, v, min, max, format)
  end

  def list_box(
    label : String,
    current_item : LibC::Int*,
    items : Array(String),
    height_items : Int32 = 3
  )
    LibImGui.ig_list_box_str_arr(label, current_item, items.map(&.to_unsafe), items.size, height_items)
  end

  def screen_cursor_pos
    LibImGui.ig_get_cursor_screen_pos_non_udt2
  end

  def begin_menu(label : String, enabled : Bool = true)
    LibImGui.ig_begin_menu(label, enabled)
  end

  def end_menu
    LibImGui.ig_end_menu
  end
end
