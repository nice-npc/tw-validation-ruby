# frozen_string_literal: true

RSpec.describe TwValidation do
  it "has a version number" do
    expect(TwValidation::VERSION).not_to be nil
  end

  context "::Id" do
    it "check" do
      expect(TwValidation::Id.check("A123456789")).to be true
      expect(TwValidation::Id.check("A1234567890")).to be false
      expect(TwValidation::Id.check("A12345678")).to be false
      expect(TwValidation::Id.check("A12345678A")).to be false
      expect(TwValidation::Id.check("å12345678")).to be false
      expect(TwValidation::Id.check("A323456789")).to be false
    end
  end
end
