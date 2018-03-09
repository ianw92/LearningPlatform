class TimerController < ApplicationController

  def start
    respond_to do |format|
      format.js
    end
  end

  def stop
    respond_to do |format|
      format.js
    end
  end

  def reset
    respond_to do |format|
      format.js
    end
  end
end
