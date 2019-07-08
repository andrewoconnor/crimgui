require "./imgui"

mode = SF::VideoMode.new(1920, 1080)

window = SF::RenderWindow
  .new(mode, "orb")
  .tap { |w|
    w.vertical_sync_enabled = true
  }.as(SF::RenderWindow)

# rectangle = SF::RectangleShape.new
# rectangle.size = SF.vector2f(44, 34)
# rectangle.fill_color = SF::Color::Black
# rectangle.outline_color = SF::Color::Red
# rectangle.outline_thickness = 5
# rectangle.position = {64, 80}

clock = SF::Clock.new

imgui = ImGui.new(window)
imgui.font_atlas_clear
imgui.add_font_from_file_ttf("/Library/Fonts/Andale Mono.ttf", 24.0)
imgui.update_font_texture

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

  # imgui.show_user_guide

  # imgui.show_metrics_window

  # imgui.begin

  # imgui.set_window_size("crimgui", ImVec2.new(250, 450))
  # if imgui.button("Test", ImVec2.new(100, 50))
  #   puts "clicked!"
  # end

  # imgui.end

  imgui.end_frame
  #
  window.clear
  imgui.render
  #   window.draw(rectangle)
  window.draw(imgui)
  window.display
end
