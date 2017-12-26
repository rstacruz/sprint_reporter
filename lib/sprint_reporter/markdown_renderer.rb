module SprintReporter
  class MarkdownRenderer
    def initialize(items, domain:, epics: nil)
      @items = items
      @domain = domain
      @epics = epics
    end

    def render
      @items.map do |item|
        render_item(item)
      end.join("\n")

      epics = @items.group_by { |it| it[:epic] }

      epics.each.map do |epic, items|
        render_epic(epic, items)
      end.join("\n\n")
    end

    def render_epic(epic, items)
      [
        render_epic_heading(epic),
        render_items(items)
      ].join("\n\n")
    end

    def render_epic_heading(epic)
      if epic
        "## #{epic}"
      else
        "## Other"
      end
    end

    def render_items(items)
      items.map { |it| render_item(it) }.join("\n")
    end

    def render_item(item)
      url = "https://#{@domain}/browse/#{item[:key]}"
      "- [`#{item[:key]}`](#{url}) #{item[:title]}"
    end
  end
end
