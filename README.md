# crimgui

Crystal bindings for dear imgui

### demo

```crystal
require "./imgui"

class ImguiTest
  property t : Float32 = 0.0f32
  property accumulator : Float32 = 0.0f32

  def mode
    @mode ||= SF::VideoMode.new(1920, 1080)
  end

  def window
    @window ||= SF::RenderWindow
      .new(mode, "orb")
      .tap { |w|
        w.vertical_sync_enabled = true
        w.mouse_cursor = cursor
      }.as(SF::RenderWindow)
  end

  def cursor
    @cursor ||= SF::Cursor.from_system(SF::Cursor::Cross)
  end

  def render_states
    @render_states ||= SF::RenderStates.new
  end

  def screen
    @screen ||= render_states.transform
      .transform_rect(SF.float_rect(0, 0, 1, 1))
      .as(SF::FloatRect)
  end

  def scale
    @scale ||= (-2 / (screen.width + screen.height)).as(Float32)
  end

  def clock
    @clock ||= SF::Clock.new
  end

  def dt
    @dt ||= 0.01
  end

  def frame_time
    clock.restart.as_seconds
  end

  def imgui
    @imgui ||= ImGui.new(window).tap { |i|
      i.font_atlas_clear
      i.add_font_from_file_ttf("/System/Library/Fonts/Supplemental/Andale Mono.ttf", 24.0)
      i.update_font_texture
    }.as(ImGui)
  end

  def process_events
    while event = window.poll_event
      imgui.process_event(event)
      case event
      when SF::Event::Closed
        window.close
      end
    end
  end

  def run
    while window.open?
      process_events

      frame_time.tap do |ft|
        @accumulator += ft
        imgui.update(ft) # don't handle events in fixed step
      end

      while accumulator >= dt
        @accumulator -= dt
        @t += dt
      end

      window.clear

      imgui.new_frame

      imgui.show_demo_window
      imgui.end_frame
      imgui.render

      window.draw(imgui)

      window.display
    end
  end
end

test = ImguiTest.new
test.run
```
