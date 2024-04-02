# frozen_string_literal: true

class InsuranceProfileCalculatorService
  AGE_THRESHOLD = 30
  INCOME_THRESHOLD = 200_000
  RENTED_HOUSE_SCORE = 1
  DEPENDENTS_SCORE = 1
  MARRIED_SCORE = 1
  RECENT_VEHICLE_YEAR_THRESHOLD = Date.today.year - 5

  def initialize(insurance_profile_id)
    @insurance_profile = InsuranceProfile.find(insurance_profile_id)
  end

  def calculate_profile
    risk_score = calculate_base_risk_score
    calculate_insurance_profile(risk_score)
  end

  private

  def calculate_base_risk_score
    base_score = 3
    base_score -= age_discount
    base_score -= income_discount
    base_score += rented_house_score
    base_score += dependents_score
    base_score += married_score
    base_score += recent_vehicle_score

    base_score
  end

  def age_discount
    return 2 if @insurance_profile.age < AGE_THRESHOLD
    return 1 if @insurance_profile.age >= AGE_THRESHOLD && @insurance_profile.age <= 40

    3
  end

  def income_discount
    @insurance_profile.income > INCOME_THRESHOLD ? 1 : 0
  end

  def rented_house_score
    @insurance_profile.house['ownership_status'] == 'rented' ? RENTED_HOUSE_SCORE : 0
  end

  def dependents_score
    @insurance_profile.dependents.positive? ? DEPENDENTS_SCORE : 0
  end

  def married_score
    @insurance_profile.married? ? MARRIED_SCORE : 0
  end

  def recent_vehicle_score
    return 1 if @insurance_profile.vehicle['year'] >= RECENT_VEHICLE_YEAR_THRESHOLD

    0
  end

  def calculate_insurance_profile(risk_score)
    {
      auto: determine_insurance_profile('auto', risk_score),
      disability: determine_insurance_profile('disability', risk_score),
      home: determine_insurance_profile('home', risk_score),
      life: determine_insurance_profile('life', risk_score)
    }
  end

  def determine_insurance_profile(type, risk_score)
    case type
    when 'auto', 'home'
      determine_generic_insurance_profile(type, risk_score, [0..1, 'economico'], [2..3, 'padrao'],
                                          [4..Float::INFINITY, 'avancado'])
    when 'disability'
      if @insurance_profile.age > 60 || @insurance_profile.income.zero?
        'inelegivel'
      else
        determine_generic_insurance_profile(type, risk_score, [0..2, 'padrao'], [3..Float::INFINITY, 'avancado'])
      end
    when 'life'
      determine_generic_insurance_profile(type, risk_score, [0..1, 'padrao'], [2..Float::INFINITY, 'avancado'])
    end
  end

  def determine_generic_insurance_profile(_type, risk_score, *conditions)
    conditions.each do |condition|
      range = condition.first
      profile = condition.last

      return profile if range.cover?(risk_score)
    end
  end
end
