require 'rails_helper'
require 'date'

RSpec.describe Contact, type: :model do
    let(:contact) { build(:contact) }
    let(:user) { create(:user) }
    before(:each)  do  contact.user=user  end

   describe '#validations credit_card and franchise' do
         
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
    #before(:each)  do  contact.credit_card=4111111111111111 end

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

  describe "#validations birth_date" do
    #before(:each)  do  contact.credit_card=4111111111111111 end

    context "test valid dates" do
      it "test birth date with format ISO 8601 %Y%m%d " do
        expect(contact).to be_valid
      end

      it "test birth date with format ISO 8601 %F " do
        contact.birth_date = "1991-11-01"
        expect(contact).to be_valid
        expect(contact.birth_date).to eq(Date.strptime("1991-11-01", "%F"))
      end

      it "test birth date with format ISO 8601 %F " do
        contact.birth_date = "19911101"
        expect(contact).to be_valid
        expect(contact.birth_date).to eq(Date.strptime("19911101", "%Y%m%d"))
      end 
    end

    context "test valid invalid dates" do
      it "test birth %Y/%m/%d " do
        contact.birth_date = "1991/11/01"
        expect(contact).not_to be_valid
      end

      it "test birth date with %Y:%m:%d " do
        contact.birth_date = "1991:11:01"
        expect(contact).not_to be_valid
        expect(contact.errors[:birth_date]).to include("This format is not valid olny acepts %Y%m%d and %F")
      end

      it "test birth date with 199111" do
        contact.birth_date = "1991111"
        expect(contact).not_to be_valid
        expect(contact.errors[:birth_date]).to include("This format is not valid olny acepts %Y%m%d and %F")
      end

      it "test birth date with 19911 without day" do
        contact.birth_date = "199111"
        expect(contact).not_to be_valid
        expect(contact.errors[:birth_date]).to include("This format is not valid olny acepts %Y%m%d and %F")
      end

      it "test birth date with 1993111 with invalid month" do
        contact.birth_date = "19913111"
        expect(contact).not_to be_valid
        expect(contact.errors[:birth_date]).to include("This format is not valid olny acepts %Y%m%d and %F")
      end

      it "test birth date with 1993-43-1 with invalid month with -" do
        contact.birth_date = "1993-43-11"
        expect(contact).not_to be_valid
        expect(contact.errors[:birth_date]).to include("This format is not valid olny acepts %Y%m%d and %F")
      end

      it "test birth date with 1993-12-99 with invalid day with -" do
        contact.birth_date = "1993-12-99"
        expect(contact).not_to be_valid
        expect(contact.errors[:birth_date]).to include("This format is not valid olny acepts %Y%m%d and %F")
      end

      it "test birth date  empty-" do
        contact.birth_date = ""
        expect(contact).not_to be_valid
        expect(contact.errors[:birth_date]).to include("This format is not valid olny acepts %Y%m%d and %F")
      end
    end
  end

  describe "#validations phone" do
    #before(:each)  do  contact.credit_card=4111111111111111 end

    context "success" do
      it "its valid phone '(+57) 320-432-05-09'" do
        contact.phone = "(+57) 320-432-05-09"
        expect(contact).to be_valid 
      end

      it "its valid phone '(+57) 311 032 05 09'" do
        contact.phone = "(+57) 311 032 05 09"
        expect(contact).to be_valid
        expect(contact.phone).to eq("(+57) 311 032 05 09")
      end

      it "its valid phone '(+00) 000-000-00-00'" do
        contact.phone = "(+00) 000-000-00-00"
        expect(contact).to be_valid 
        expect(contact.phone).to  eq("(+00) 000-000-00-00")
      end
    end

    context "no valid" do
      it "its valid phone '(+00) 000-000-00'" do
        contact.phone = "(+00) 000-000-00"
        expect(contact).not_to be_valid 
      end

      it "its valid phone '(00) 000-000-00-00'" do
        contact.phone = "(00) 000-000-00-00"
        expect(contact).not_to be_valid 
      end

      it "its valid phone ''" do
        contact.phone = ""
        expect(contact).not_to be_valid 
      end

      it "its valid phone '(00) 0000-000-0'" do
        contact.phone = "(00) 0000-000-0"
        expect(contact).not_to be_valid 
      end

      it "its valid phone '(00) 0000-000-0'" do
        contact.phone = "(00) 0000-000-0"
        expect(contact).not_to be_valid 
      end
    end
  end

  describe "#validations address" do
    #before(:each)  do  contact.credit_card=4111111111111111 end

    context "success address" do
      it "is valid from factory" do
        expect(contact).to be_valid
      end

      it  "is valid for cr 5 6-25" do
        contact.address = "cr 5 6-25"
        expect(contact).to be_valid
      end

      it  "is valid for cr 5 6-25" do
        contact.address = 124343
        expect(contact).to be_valid
      end
    end

    context "no valid address" do
      it "is not valid for ''" do
        contact.address = ""
        expect(contact).not_to be_valid
      end
    end
  end
  
  describe "#validations email" do
    #before(:each)  do  contact.credit_card=4111111111111111 end
    context "success" do
      it "is valid from factory" do
        expect(contact).to be_valid
      end

      it "is valid with to@to.com" do
        contact.email = "to@to.com" 
        expect(contact).to be_valid
      end

      it "is valid with to@tomm.com" do
        contact.email = "to@to.com"
        expect(contact).to be_valid
      end
    end

    context "it not valid" do
      it "is valid with totomm.com" do
        contact.email = "toto.com"
        expect(contact).not_to be_valid
      end

      it "is valid with @tomm.com" do
        contact.email = "@to.com"
        expect(contact).not_to be_valid
      end

      it "is valid with @tomm.com" do
        contact.email = "ddas@dasd"
        expect(contact).not_to be_valid
      end

      it "is valid with ''" do
        contact.email = ""
        expect(contact).not_to be_valid
      end
    end
  end
end
