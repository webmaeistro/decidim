# frozen_string_literal: true

module Decidim
  module Budgets
    # This cell renders a checkmark with a text.
    class ProjectVotedHintCell < Decidim::ViewModel
      include Decidim::IconHelper
      alias voted? model

      def show
        return unless voted?

        content_tag :div, safe_join(hint), class: "text-sm mt-s text-success"
      end

      private

      def hint
        contents = []
        contents << icon("check", role: "img")
        contents << " "
        contents << t("decidim.budgets.projects.project.you_voted")
      end
    end
  end
end
