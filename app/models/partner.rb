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

  def total_driver_insurance_charge_pounds
    total = 0
    self.driver_insurances.each do |driver_insurance|
      total = total + driver_insurance.total_charge_pounds
    end

    return total
  end

  def total_vehicle_owner_insurance_v2_charges_pounds
    total = 0

    # self.owned_vehicles.each do |vehicle|
    #   vehicle.vehicle_owner_insurances.each do |vehicle_insurance|
    #     total = vehicle_insurance.v2_total_charge_pounds
    #   end
    # end
    #
    # if self.owned_vehicles.length >= 3
    #   total = (total / 100) * 110
    # end

    return total
  end

end
