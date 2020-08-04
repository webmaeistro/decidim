# frozen_string_literal: true

module Decidim
  module Budgets
    # This cell renders selected badge if the project has been selected
    class ProjectSelectedBadgeCell < Decidim::ViewModel
      delegate :voting_finished?, to: :parent_controller

      alias selected? model

      def show
        if voting_finished? && selected?
          content_tag :span, class: "card__text--status success" do
            t("decidim.budgets.projects.project.selected")
          end
        end
      end
    end
  end
end
