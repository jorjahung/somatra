module MoodsHelper
  def class_for_mood(mood)
    if mood.score > 0
      "class=positive"
    elsif mood.score == 0
      "class=neutral"
    else
      "class=negative"
    end
  end
end
