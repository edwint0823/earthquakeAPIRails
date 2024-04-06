# frozen_string_literal: true

class Feature < ApplicationRecord
  has_many :comments

  scope :filter_by_mag_type, ->(mag_types) { where(mag_type: mag_types.split(',')) if mag_types.present? }
  scope :paginate, ->(page:, per_page:) {
    offset((page.to_i - 1) * per_page.to_i).limit(per_page.to_i)
  }
end
