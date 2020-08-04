# frozen_string_literal: true

module Decidim
  module Budgets
    # This cell renders the support count.
    # Two possible layouts: One or two lines
    class ProjectSupportsCountCell < Decidim::ViewModel
      include Decidim::IconHelper
      delegate :show_support_count?, to: :parent_controller
      alias count model

      def show
        return unless show_support_count?

        content_tag :div, content
      end

      private

      def content
        if options[:layout] == :one_line
          label(t("decidim.budgets.projects.project.count", count: count))
        else
          safe_join([number, label(t("decidim.budgets.projects.project.supports",
                                     count: count))])
        end
      end

      def number
        content_tag :div, count, class: "text-large"
      end

      def label(i18n_string)
        content_tag :span, i18n_string, class: "text-uppercase text-small"
      end
    end
  end
end
