class Event < ApplicationRecord
  belongs_to :location, :foreign_key => 'at_locations_table_id', :primary_key => 'at_locations_id', optional: true

  def transfer?
    major_event_type == "Transfer of Possesion"
  end

  def building?
    major_event_type == "Building Activity"
  end

  def military?
    major_event_type == "Military Activity"
  end

  def charter?
    major_event_type == "Charter/Treaty"
  end

  def date_range
    if (end_date.nil? && earliest_begin_date.nil?)
      nil
    elsif (earliest_begin_date.present? && end_date.nil?)
      formatted_earliest_date
    elsif (earliest_begin_date.present? && end_date.present?)
      formatted_earliest_date + ' - ' + formatted_end_date
    elsif (earliest_begin_date.nil? && end_date.present?)
      ' - ' + formatted_end_date
    else
      nil
    end
  end

  def formatted_earliest_date
    return '' if earliest_begin_date.nil?
    date = earliest_begin_date.strftime("%m/%d/%Y")
    if date.include? '01/01/'
      date.sub!(/^01\/01\//, "")
    end
    if date.include? '/'
      return date
    else
      date.to_i.to_s
    end
  end

  def formatted_end_date
    return '' if end_date.nil?
    date = end_date.strftime("%m/%d/%Y")
    if date.include? '01/01/'
      date.sub!(/^01\/01\//, "")
    end
    if date.include? '/'
      return date
    else
      date.to_i.to_s
    end
  end

end
