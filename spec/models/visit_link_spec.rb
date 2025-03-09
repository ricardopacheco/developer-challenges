require "rails_helper"

RSpec.describe VisitLink, type: :model do
  describe "Associations" do
    it { is_expected.to belong_to(:link).counter_cache(true) }
  end
end
