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
    vehicle = Vehicle.create(driver_insurance_daily_rate_pounds: DriverInsurance::DEFAULT_DAILY_RATE)
    driver_insurance = DriverInsurance.create(start_date: Date.today, end_date: Date.today + daysDiff.days,
                                              vehicle: vehicle)
    expect(driver_insurance.total_price).to eq daysDiff * vehicle.driver_insurance_daily_rate_pounds
  end

  it "calculates the price for all the insurance for one driver"

end
