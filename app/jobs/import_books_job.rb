class ImportBooksJob < ApplicationJob
  queue_as :default

  def perform(import_id, csv_file_path)
    import = Import.find(import_id)
    import.mark_as_processing!

    created_count = 0
    skipped_count = 0
    total_rows = 0
    errors = []

    begin
      require 'csv'

      CSV.foreach(csv_file_path, headers: true, header_converters: :symbol, encoding: 'bom|utf-8') do |row|
        total_rows += 1

        title = row[:title]&.strip
        author_name = row[:author_name]&.strip
        year = row[:year]&.to_i
        description = row[:description]&.strip

        if title.blank? || year.nil? || year.zero?
          skipped_count += 1
          errors << "Row #{total_rows}: Missing required fields (title or year)"
          next
        end

        author = nil
        if author_name.present?
          author = Author.find_by('name ILIKE ?', author_name)
          if author.nil?
            skipped_count += 1
            errors << "Row #{total_rows}: Author '#{author_name}' not found"
            next
          end
        end

        book = Book.new(
          title: title,
          author: author,
          year: year,
          description: description
        )

        if book.save
          created_count += 1
        else
          skipped_count += 1
          errors << "Row #{total_rows}: #{book.errors.full_messages.join(', ')}"
        end
      end

      import.update!(
        total_rows: total_rows,
        created_count: created_count,
        skipped_count: skipped_count,
        error_messages: errors.any? ? errors.join("\n") : nil
      )

      import.mark_as_completed!

      UserMailer.import_report(import).deliver_now if UserMailer.respond_to?(:import_report)
    rescue StandardError => e
      import.mark_as_failed!(e.message)
      raise e
    ensure
      File.delete(csv_file_path) if File.exist?(csv_file_path)
    end
  end
end
