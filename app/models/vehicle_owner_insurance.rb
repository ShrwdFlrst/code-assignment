# Vehicle owner insurance is issued to vehicle owners, but they only pay for all days the vehicle is NOT on rent by drivers
#                                                                          This is to cover periods the vehicle is waiting to be rented and sitting in the parking lot
#                                                                          Vehicle insurance pricing includes the end date (unlike driver insurance)
# eg. a vehicle insurance from 1st Oct to 8th Oct is 8 days of cover, at a rate of £1, gives a total of £8
# if the vehicle is rented from 2nd Oct to 5th Oct then the owner pays for 3 less days, giving a total of £5

class VehicleOwnerInsurance < ActiveRecord::Base

  belongs_to :vehicle

  def total_days_covered
    (end_date - start_date).to_f + 1
  end

  def total_days_charged_for
    date_range = (start_date..end_date).to_a
    days_not_overlapping = date_range.length
    
    vehicle.driver_insurances.each do |driver_insurance|
      overlap = date_range & (driver_insurance.start_date..end_date).to_a
      days_not_overlapping = days_not_overlapping - overlap.length
    end

    return [days_not_overlapping, 0].max
  end

  def total_charge_pounds
    total_days_charged_for * vehicle.vehicle_owner_insurance_daily_rate_pounds
  end

end
