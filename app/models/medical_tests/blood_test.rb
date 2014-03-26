class BloodTest < MedicalTest
  validates :taken_on, presence: true, uniqueness: true

end