module MonthHelpers
  DateTime.class_eval do
    def self.months_between(start_date, end_date)
      (end_date.month - start_date.month) + 12 * (end_date.year - start_date.year)
    end

    def self.all_months_between(start_date, end_date)
      start_month = start_date.month
      end_month = end_date.month
      (start_month..(start_month+months_between(start_date, end_date))).to_a.map do |month|
        month%12 == 0 ? 12 : month%12
      end
    end
  end
end
