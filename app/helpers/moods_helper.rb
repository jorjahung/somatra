module MoodsHelper
  def class_for(mood)
    if mood.score > 0
      "class=positive"
    elsif mood.score == 0
      "class=neutral"
    else
      "class=negative"
    end
  end
end
