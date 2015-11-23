describe "I18n" do
  describe "translate" do
    it "should translate string" do
      I18n.translate("test.string").should == "Test string"
    end

    it "should return key for untranslated string" do
      I18n.translate("foo.bar").should == "foo.bar"
    end

    it "should plug in substitutions" do
      I18n.translate("test.substitutions", :count => 5).should == "5 substitutions"
    end

    it "substitutes multiple instances" do
      I18n.translate("test.multiple_substitutions", :count => 5).should == "5 substitutions 5"
    end

    it "should have shortcut" do
      I18n.t("test.string").should == I18n.translate("test.string")
    end
  end

  describe "locale" do
    it "should return the current locale" do
      I18n.locale.should == "en-US"
    end
  end
end
