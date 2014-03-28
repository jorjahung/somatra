module BloodTestsHelper

  def methods
    ["hb",
      "mcv",
      "wbc",
      "platelets",
      "neutrophils",
      "lymphocytes",
      "alt",
      "alk_phos",
      "creatinine",
      "esr",
      "crp"
    ]
  end

  def class_for(blood_test, method)
    return "class=empty-value" if has_empty_value?(blood_test, method)
    if within_range?(blood_test, method)
      "class=no-danger"
    else
      "class=danger"
    end
  end

  def within_range?(blood_test, method)
    if method == 'crp'
      return true if blood_test['crp'] =~ /^<(?:5|4|3|2|1)$/
      return @ranges[method].include?(value_for(blood_test, method).to_i) if blood_test['crp'] =~ /^\d+$/
      return false
    else
      @ranges[method].include? value_for(blood_test, method)
    end
  end

  def value_for(blood_test, method)
    blood_test[method]
  end

  def has_empty_value?(blood_test, method)
    value_for(blood_test, method).nil? || value_for(blood_test, method) == ''
  end
end
