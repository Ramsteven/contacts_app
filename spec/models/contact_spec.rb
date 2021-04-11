require 'rails_helper'

RSpec.describe Contact, type: :model do
    let(:contact) { build(:contact) }
    let(:user) { create(:user) }
    before(:each)  do  contact.user=user  end

   describe '#validations credit_card' do
         
      it "tests contact be valid amex card" do
        contact.credit_card = "371449635398431"
        expect(contact).to be_valid #contact.valid? == true
        expect(contact.franchise).to eq('amex')
      end

      it "tests contact be valid dinners_inter card" do
        contact.credit_card = "36569309025904"
        expect(contact).to be_valid #contact.valid? == true
        expect(contact.franchise).to eq('dinners_inter')
      end

      it "tests contact be valid discover card" do
        contact.credit_card = "6011111111111117"
        expect(contact).to be_valid #contact.valid? == true
        expect(contact.franchise).to eq('discover')
      end

      it "tests contact be valid jcb card" do
        contact.credit_card = "3530111333300000"
        expect(contact).to be_valid #contact.valid? == true
        expect(contact.franchise).to eq('jbc')
      end

      it "tests contact be valid master card" do
        contact.credit_card = "5555555555554444"
        expect(contact).to be_valid #contact.valid? == true
        expect(contact.franchise).to eq('master')
      end

     it "tests contact be valid  card" do
        contact.credit_card = "4111111111111111"
        expect(contact).to be_valid #contact.valid? == true
        expect(contact.franchise).to eq('visa')
      end

      it "tests contact NOT be valid passing value different to numbers" do
        contact.credit_card = "411111111111R111"
        contact.save
        expect(contact.errors[:credit_card]).to include("is not credit_card number")
        expect(contact.errors[:franchise]).to eq([])
      end

      it "tests contact NOT be valid passing number card that not match with franchise" do
        contact.credit_card = "999111111111111"
        contact.save
          expect(contact.errors[:credit_card]).to include("this number dont have any franchise valid")
      end

      it "tests contact NOT be valid passing number card that not match with franchise" do
        contact.credit_card = ""
        contact.save
        expect(contact.errors[:credit_card]).to include("can't be blank")
        expect(contact.errors[:franchise]).to include("can't be blank")
      end

      it "tests contact NOT be valid passing number card that not match with franchise" do
        contact.credit_card = 4111111111111111
        expect(contact.save).to eq(true) #contact.valid? == true
        expect(contact.franchise).to include("visa")
      end
   end

   describe "#validations fullname" do
    before(:each)  do  contact.credit_card=4111111111111111 end

      it "tests contact valid with name" do
          expect(contact).to be_valid#contact.valid? == true
          expect(contact.save).to eq(true)
         expect(contact.fullname).to include("jose Gabriel")
      end


      context "tests contact  not be valid with characters different to - and empty" do

        it "fullname have @" do
          contact.fullname = "jose @gabriel"
          contact.save 
          expect(contact.errors[:fullname]).to include("only allows letters")
        end

        it "fullname have _" do
          contact.fullname = "jose _gabriel"
          contact.save 
          expect(contact.errors[:fullname]).to include("only allows letters")
        end

        it "fullname with numbers" do
          contact.fullname = 444
          contact.save 
          expect(contact.errors[:fullname]).to include("only allows letters")
        end
        it "fullname empty" do
          contact.fullname = ""
          contact.save 
          expect(contact.errors[:fullname]).to include("can't be blank")
        end
      
      end

      context "tests contact valid with name with characters -" do
        it "fullname with - beetween names" do
          contact.fullname = "Jose-gabriel"
          contact.save 
          expect(contact.fullname).to include("Jose-gabriel")
        end

        it "fullname with many -" do
          contact.fullname = "-Jose-gabriel-"
          contact.save 
          expect(contact.fullname).to include("-Jose-gabriel-")
        end
      end
   end

  describe "#validations bith_date" do
    before(:each)  do  contact.credit_card=4111111111111111 end

    context "test valid dates" do
      it "test birth date with format ISO 8601 %Y%m%d " do
        expect(contact).to be_valid
      end
    end
  end
end
