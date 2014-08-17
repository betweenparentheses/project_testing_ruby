require "./caesar_cipher.rb"

describe "Caesar" do
  describe "#caesar_cipher" do
    before(:all) {@c = Caesar.new}

    it "shifts characters in a string by the number provided" do
      expect(@c.caesar_cipher("abc", 3)).to eql("def")
    end

    it "converts both uppercase and lowercase characters correctly" do
      expect(@c.caesar_cipher("AbCd", 3)).to eql("DeFg")
    end

    it "leaves spaces and punctuation alone" do
      expect(@c.caesar_cipher("A. b? Cd!!!!", 3)).to eql("D. e? Fg!!!!")
    end

    it "correctly wraps around shifts greater than 26" do
      expect(@c.caesar_cipher("abc", 29)).to eql(@c.caesar_cipher("abc", 3))
    end

    it "takes negative shift values" do
      expect(@c.caesar_cipher("abc", -3)).to eql("xyz")
    end

    it "can decode itself" do
      expect(@c.caesar_cipher((@c.caesar_cipher("bleh blah Bluh!", 18)), -18)).to eql("bleh blah Bluh!")
    end

  end
end
