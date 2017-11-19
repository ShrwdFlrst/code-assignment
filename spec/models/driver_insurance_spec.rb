require 'rails_helper'

RSpec.describe DriverInsurance, type: :model do

  it "calculates the number of days to charge for a driver insurance policy" do
    driver_insurance = DriverInsurance.create(start_date: Date.today, end_date: Date.today + 1.week)
    expect(driver_insurance.numds).to eq 7
  end

  it "calculates the number of days to charge for all the insurance for one driver" do
    driver = Partner.create(name: "Danny Driver")
    driver_insurance = DriverInsurance.create(start_date: Date.today, end_date: Date.today + 1.week, driver: driver)
    driver_insurance2 = DriverInsurance.create(start_date: Date.today - 3.weeks, end_date: Date.today - 1.week, driver: driver)

    expect(driver.total_days_charged_for_all_driver_insurance_policies).to eq 21
  end

  it "calculates the price for a driver insurance policy" do
    daysDiff = 7
    vehicle = Vehicle.create(driver_insurance_daily_rate_pounds: 58.50)
    driver_insurance = DriverInsurance.create(start_date: Date.today, end_date: Date.today + daysDiff.days,
                                              vehicle: vehicle)
    expect(driver_insurance.total_charge_pounds).to eq daysDiff * vehicle.driver_insurance_daily_rate_pounds
  end

  it "calculates the price for all the insurance for one driver" do
    driver = Partner.create(name: "Danny Driver")
    vehicle1 = Vehicle.create(driver_insurance_daily_rate_pounds: 58.50)
    driver_insurance1 = DriverInsurance.create(start_date: Date.today, end_date: Date.today + 1.week,
                                              vehicle: vehicle1, driver: driver)
    vehicle2 = Vehicle.create(driver_insurance_daily_rate_pounds: 34.75)
    driver_insurance2 = DriverInsurance.create(start_date: Date.today + 1.week, end_date: Date.today + 2.week,
                                              vehicle: vehicle2, driver: driver)
    expected_total = driver_insurance1.total_charge_pounds + driver_insurance2.total_charge_pounds

    expect(driver.total_driver_insurance_charge_pounds).to eq expected_total
  end

end
