# A Partner can be either a Driver or an Owner

class Partner < ActiveRecord::Base

  has_many :driver_insurances, foreign_key: "driver_id"
  has_many :owned_vehicles, class_name: "Vehicle", foreign_key: "owner_id"

  def total_days_charged_for_all_driver_insurance_policies
    days = 0
    self.driver_insurances.each do |driver_insurance|
      days = days + driver_insurance.numds
    end

    return days
  end

  def total_driver_insurance_charge
    total = 0
    self.driver_insurances.each do |driver_insurance|
      total = total + driver_insurance.total_price
    end

    return total
  end

  def total_vehicle_owner_insurance_v2_charges_pounds

  end

end
