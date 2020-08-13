# frozen_string_literal: true

module Decidim
  module Debates
    module Admin
      # This class holds a Form to create/update debates from Decidim's admin panel.
      class DebateForm < Decidim::Form
        include TranslatableAttributes

        translatable_attribute :title, String
        translatable_attribute :description, String
        translatable_attribute :instructions, String
        translatable_attribute :information_updates, String
        attribute :start_time, Decidim::Attributes::TimeWithZone
        attribute :end_time, Decidim::Attributes::TimeWithZone
        attribute :decidim_category_id, Integer

        validates :title, translatable_presence: true
        validates :description, translatable_presence: true
        validates :instructions, translatable_presence: true
        validates :start_time, presence: { if: ->(object) { object.end_time.present? } }, date: { before: :end_time, allow_blank: true }
        validates :end_time, presence: { if: ->(object) { object.start_time.present? } }, date: { after: :start_time, allow_blank: true }

        validates :category, presence: true, if: ->(form) { form.decidim_category_id.present? }

        def map_model(model)
          self.decidim_category_id = model.categorization.decidim_category_id if model.categorization
          presenter = DebatePresenter.new(model)

          self.title = presenter.title(all_locales: title.is_a?(Hash))
          self.description = presenter.description(all_locales: description.is_a?(Hash))
        end

        def category
          return unless current_component

          @category ||= current_component.categories.find_by(id: decidim_category_id)
        end
      end
    end
  end
end
