
class MoodsController < ApplicationController
  def index
   @mood = Mood.new
   @moods = Mood.order('created_at DESC').all
  end

  def create
   @mood = Mood.create(mood_params)
   if @mood.save
      analyze_sentiment
      @mood = Mood.new
      @moods = Mood.order('created_at DESC').all
      render "moods/index"
    else
      flash.now[:notice] = "Something went wrong and I didn't get your mood"
    end
  end

private
  def mood_params
    params.require(:mood).permit(:user_mood, :stored_sentiment, :score)
  end

  def analyze_sentiment
    your_mood = Mood.last.user_mood
    Sentimental.load_defaults
    Sentimental.threshold = 0.1
    analyzer = Sentimental.new
    tone = analyzer.get_sentiment(your_mood)
    mood_score = analyzer.get_score(your_mood)

    Mood.last.update(score: mood_score)
    Mood.last.update(stored_sentiment: tone)

    if tone == :negative   
      flash.now[:notice] = "You said: #{your_mood}.<br>We've stored this as a negative emotion.".html_safe
    elsif tone == :neutral
      flash.now[:notice] = "You said: #{your_mood}.<br>We've stored this as a neutral emotion.".html_safe
    else   
      flash.now[:notice] = "You said: #{your_mood}.<br>We've stored this as a positive emotion.".html_safe
    end
  end

end
