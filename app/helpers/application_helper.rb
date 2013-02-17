module ApplicationHelper
  def display_name animal
    if !animal.name.blank? && !animal.call_name.blank?
      "#{animal.name} (#{animal.call_name})"
    elsif !animal.name.blank?
      "#{animal.name}"
    elsif !animal.call_name.blank?
      "#{animal.call_name}"
    else
      "no known name"
    end
  end

  def readable_date event
    string = []
    if event.month
      string << Date::MONTHNAMES[event.month]
      if event.day
        string << " " << event.day
      end
      string << ", "
    end
    string << event.year
    string.join
  end

  def life_string animal
    if animal.birth && animal.death
      "#{readable_date animal.birth} \u2014 #{readable_date animal.death}"
    elsif animal.birth
      "born #{readable_date animal.birth}"
    elsif animal.death
      "died #{readable_date animal.birth}"
    else
      nil
    end
  end

  def display_string animal
    life_string = self.life_string animal
    if life_string
      "#{display_name animal} (#{life_string})"
    else
      display_name animal
    end
  end

end
