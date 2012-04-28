#!/bin/env ruby

require 'rubygems'
require 'rubygame'

class Game
  def initialize
    @screen = Rubygame::Screen.new [640,480], 0, [Rubygame::HWSURFACE, Rubygame::DOUBLEBUF]
    @screen.title = "Generic Game!"

    @queue = Rubygame::EventQueue.new
    @clock = Rubygame::Clock.new
    @clock.target_framerate = 30

    @xpos = 320
    @ypos = 240

    @thrust = 0
    @angle = 0

    @anglevector = 0
  end
  
  def run
    loop do
      update
      draw
      @clock.tick
    end
  end
  
  def update
    @xpos += @xvector
    @xvector -= @xvectoraccel if @xvector > 0
    @xvector += @xvectoraccel if @xvector < 0
    @ypos += @yvector
    @yvector -= @yvectoraccel if @yvector > 0
    @yvector += @yvectoraccel if @yvector < 0

    @queue.each do |ev|
      case ev
        when Rubygame::QuitEvent
          Rubygame.quit
          exit
        when Rubygame::KeyDownEvent
          case ev.key
            when Rubygame::K_RIGHT
              @anglevector = 1

            when Rubygame::K_LEFT
              @anglevector = -1
            when Rubygame::K_UP
              @thrust = 5
            when Rubygame::K_DOWN
              @thrust = -5
          end
        when Rubygame::KeyUpEvent
          case ev.key
            when Rubygame::K_RIGHT
              @anglevector = 0
            when Rubygame::K_LEFT
              @anglevector = 0
            when Rubygame::K_UP
              @thrust = 0
            when Rubygame::K_DOWN
              @thrust = 0
          end
      end

    end
  end
  
  def draw
    @screen.fill([0,0,0])
    @screen.draw_box( [@xpos,@ypos], [@xpos+8,@ypos+8], [255,255,255] )
    @screen.update
  end
end

game = Game.new
game.run