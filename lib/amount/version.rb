# frozen_string_literal: true
require 'fixed'

class Amount < Fixed
  VERSION = "1.0.0"
end


__END__

# Major version bump when breaking changes or new features
# Minor version bump when backward-compatible changes or enhancements
# Patch version bump when backward-compatible bug fixes, security updates etc

1.0.0

  - Extends the fixed gem
  - Adds currency support to handle monetary values
  - Convenient constructors for creating money amounts
