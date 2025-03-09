# frozen_string_literal: true

class VisitLink < ApplicationRecord
  belongs_to :link, counter_cache: true
end
