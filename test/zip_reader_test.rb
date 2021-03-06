require_relative 'test_helper'
require 'zip'

# Unit Test for IOStreams::Zip
module Streams
  class ZipReaderTest < Minitest::Test
    describe IOStreams::Zip::Reader do
      before do
        @file_name = File.join(File.dirname(__FILE__), 'files', 'text.zip')
        @zip_data  = File.open(@file_name, 'rb') { |f| f.read }
        @data      = Zip::File.open(@file_name) { |zip_file| zip_file.first.get_input_stream.read }
      end

      describe '.open' do
        it 'file' do
          result = IOStreams::Zip::Reader.open(@file_name) do |io|
            io.read
          end
          assert_equal @data, result
        end

        it 'stream' do
          result = File.open(@file_name) do |file|
            IOStreams::Zip::Reader.open(file) do |io|
              io.read
            end
          end
          assert_equal @data, result
        end
      end

    end
  end
end
