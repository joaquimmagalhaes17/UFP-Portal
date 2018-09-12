module Api::AdminHelper
  def self.parse_to_table(users)
    {
        total: users.count,
        per_page: users.count,
        current_page: 1,
        last_page: 1,
        next_page_url: nil,
        prev_page_url: nil,
        from: 0,
        to: users.count,
        data: users
    }
  end
end
