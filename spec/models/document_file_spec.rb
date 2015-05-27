# == Schema Information
#
# Table name: document_files
#
#  id                :integer          not null, primary key
#  document_id       :integer          not null
#  user_id           :integer          not null
#  file_name         :string           not null
#  file_content_type :string           not null
#  file_md5          :string           not null
#  comments          :string
#  download_count    :integer          default("0"), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'rails_helper'

RSpec.describe DocumentFile, type: :model do
  describe "instance methods" do
    describe "save_with_file" do
      before do
        document_file_params = ActionController::Parameters.new(
          document_id: 1,
          user_id: 1,
          comments: "hoge",
          file_name: "dummy.pdf",
          file_content_type: "application/pdf",
          file_md5: "c348a159e06d03e9905ed043ab249dda"
        ).permit(
          :document_id,
          :user_id,
          :comments,
          :file_name,
          :file_content_type,
          :file_md5
        )

        tf = Tempfile.new("dummy")
        @file_raw = File.read(File.join(Rails.root, "misc", "uploaded", "000001-dummy.pdf"))
        tf << @file_raw

        @df = DocumentFile.new(document_file_params)
        @df.instance_variable_set(:@tempfile, tf)
      end

      it "save an AR object and a file, and returs true" do
        old_size = DocumentFile.count
        expect(@df.save_with_file).to be(true)
        expect(DocumentFile.count).to eq(old_size + 1)
        expect(File.read(@df.file_fullpath)).to eq(@file_raw)
      end

      it "returns false if anything wrong occurs" do
        old_size = DocumentFile.count
        @df.document_id = nil
        expect(@df.save_with_file).to be(false)
        expect(DocumentFile.count).to eq(old_size)
      end
    end

    describe "file_fullpath" do
      it "returns the path to saved file" do
        df = DocumentFile.new(id: 1, file_name: "dummy.pdf")
        expect(df.file_fullpath).to eq("/tmp/000001-dummy.pdf")
      end
    end
  end
end

