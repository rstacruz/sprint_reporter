module SprintReporter
  class MarkdownRenderer
    PRIORITIES = {
      'Highest' => 5,
      'High' => 4,
      'Medium' => 3,
      'Low' => 2,
      'Lowest' => 1
    }

    TYPE_INDICES = {
      'Feature' => -3,
      'Bug' => -2,
      'Task' => -1
    }

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

      defined_keys = @epics ? @epics.keys : []
      undefined_keys = epics.keys - defined_keys
      keys = defined_keys + undefined_keys

      # Move `nil` to the end
      keys = keys.sort_by { |epic| epic.nil? ? 1 : 0 }

      keys.map do |epic|
        items = epics[epic]
        render_epic(epic, items) if items
      end.compact.join("\n\n")
    end

    def render_epic(epic, items)
      [
        render_epic_heading(epic),
        render_items(items)
      ].join("\n\n")
    end

    def render_epic_heading(epic)
      if epic && @epics && @epics[epic]
        "## #{@epics[epic]}"
      elsif epic
        "## #{epic}"
      else
        "## Other"
      end
    end

    def render_items(items)
      items
        .sort_by { |item| [ get_type_index(item), get_priority_index(item) ] }
        .group_by { |item| item[:type] }
        .map { |(group, items)| render_group(group, items) }
        .join("\n\n")
    end

    def render_group(group, items)
      [
        "##### #{render_type_heading(group)}:",
        items.map { |item| render_item(item) }.join("\n")
      ].join("\n\n")
    end

    def render_type_heading(type)
      case type
      when "Feature" then "New and updated"
      when "Bug" then "Fixed"
      else type
      end
    end

    def render_item(item)
      url = "https://#{@domain}/browse/#{item[:key]}"
      title = item[:title]
      key = item[:key]

      # Bold the high priority items.
      title = "**#{title}**" if is_highest_priority?(item)

      # Render as Markdown
      "- [`#{key}`](#{url}) #{title}"
    end

    private

    # Returns a number for a given item's priority.
    # Used for sorting.
    #
    #     get_priority_index(item)
    #     # => -5...0
    #
    def get_priority_index(item)
      -(PRIORITIES[item && item[:priority]] || 0)
    end

    # Returns a number for the given item's type ('feature' / 'bug').
    # Used for sorting.
    #
    #     get_type_index(item)
    #     # => -3...0
    #
    def get_type_index(item)
      (TYPE_INDICES[item && item[:type]] || 0)
    end

    # Checks if the priority of the given +item+ is +'Highest'+.
    def is_highest_priority?(item)
      item && item[:priority] == 'Highest'
    end
  end
end
