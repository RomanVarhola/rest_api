require 'json'

module Requests
  module JsonHelpers
    def random_email
      Faker::Internet.email
    end

    def password
      '12345678'
    end
    
    # used for update checks. Is the name of this data attribute returned
    # in the JSON matching the original, or not?
    def expect_json_data_attribute_to_not_match(attr, match_term)
      expect_json_data_to_be_a_hash
      expect(json.dig('data', attr)).to_not eq match_term
    end

    # In a response, did we get an ID back? (which indicates a good response)
    def expect_json_to_have_data_id
      expect_json_data_to_be_a_hash
      got_id = json.dig('data', 'id')&.to_i
      expect(got_id).to_not be_nil
    end

    # When user isn't admin, then we have error message
    def expect_json_to_get_error_message
      expect(json['message']).to eq 'You are not admin'
    end

    def expect_json_to_get_error_after_registration
      expect(json['password']).to eq ["can't be blank"]
    end

    # Does the JSON response match the ID that we are expecting?
    def expect_json_to_contain_id(match_id)
      expect_json_data_to_be_a_hash
      got_id = json.dig('data', 'id')&.to_i
      expect(got_id).to eq match_id
    end

    # Did the JSON response return any data?
    def expect_json_data_length_to_be_greater_than_zero
      expect_json_data_length_to_be_greater_than(0)
    end

    # Is the data an array, and is that array greater than x?
    def expect_json_data_length_to_be_greater_than(kount)
      expect_json_data_to_be_an_array
      the_length = json['data'].length
      expect(the_length).to be > kount
    end

    # Is the JSON data an array, and is that array of length x?
    def expect_json_data_length_to_be(kount)
      expect_json_data_to_be_an_array
      the_length = json['data'].length
      expect(the_length).to eq kount
    end

    def expect_json_data_to_be_an_array
      expect(json['data']).to be_a_kind_of Array
    end

    def expect_json_data_to_be_a_hash
      expect(json['data']).to be_a_kind_of Hash
    end

    def data_form(type, attrs = {})
      { data: { type: type, attributes: attrs } }
    end

    def json
      ::JSON.parse(response.body)
    end
  end
end

RSpec.configure do |config|
  config.include Requests::JsonHelpers
end