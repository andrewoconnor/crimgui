require "crsfml"
require "./lib"

module ImGui
  class SFML
    property window : SF::RenderWindow
    property target : SF::RenderTarget
    property load_default_font : Bool
    property imgui_context : Void*
    property window_has_focus : Bool
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
    end

    def finalize
      LibImGui.imguiio_destroy(io)
      LibImGui.imfontatlas_destroy(font_atlas)
      LibImGui.imguicontext_destroy(imgui_context)
    end

    def load_cursor(imgui_cursor, sfml_cursor)
      mouse_cursors[imgui_cursor.value] = SF::Cursor.new
      mouse_cursor_loaded[imgui_cursor.value] = mouse_cursors[imgui_cursor.value].load_from_system(sfml_cursor)
    end

    def font_atlas : LibImGui::ImFontAtlas*
      @font_atlas ||= LibImGui.imfontatlas_allocate
    end

    def update_font_texture(imgui_io = nil)
      imgui_io ||= io
      imgui_io.value.fonts = font_atlas

      LibImGui.imfontatlas_get_tex_data_as_rgba32(font_atlas, out pixels, out width, out height, out bytes_per_pixel)

      font_texture.create(width, height)
      font_texture.update(pixels)

      imgui_io.value.fonts.value.tex_id = pointerof(@font_texture_handle).as(Void*)
    end

    def focus?
      window_has_focus
    end

    def io : LibImGui::ImGuiIO*
      @io ||= LibImGui.imguiio_allocate.tap do |i|
        # init supported features
        i.value.backend_platform_name = "crimgui_sfml"
        i.value.backend_flags = LibImGui::ImGuiBackendFlags::HasGamepad | LibImGui::ImGuiBackendFlags::HasMouseCursors | LibImGui::ImGuiBackendFlags::HasSetMousePos

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
        i.value.key_map[LibImGui::ImGuiKey::Delete.value] = SF::Keyboard::Key::Delete.value
        i.value.key_map[LibImGui::ImGuiKey::Backspace.value] = SF::Keyboard::Key::Backspace.value
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

sfml = ImGui::SFML.new(window)

puts String.new(sfml.io.value.backend_platform_name)
puts sfml.io.value.backend_flags
puts sfml.io.value.key_map
puts sfml.io.value.display_size
puts sfml.mouse_cursor_loaded
puts sfml.io.value.fonts.value.tex_id.as(Int32*).value
