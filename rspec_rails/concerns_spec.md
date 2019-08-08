> refer to: https://stackoverflow.com/questions/16525222/how-to-test-a-concern-in-rails
> https://relishapp.com/rspec/rspec-core/v/3-5/docs/example-groups/shared-examples

## 最初的写法, 借鉴 https://stackoverflow.com/questions/16525222/how-to-test-a-concern-in-rails

**例子源自于 Mynavi**

```ruby
# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
shared_examples_for 'concerns/locale' do
  let(:model) { described_class }
  let(:instance) { build(model.name.underscore.to_sym) }

  describe "#simplified_chinese?" do
    context 'when locale is nil' do
      before do
        instance.locale = nil
      end

      it 'return true' do
        expect(instance.simplified_chinese?).to be_truthy
      end
    end
  end
end

describe User, type: :model do
  it_behaves_like 'concerns/locale'
end

# rubocop:enable Metrics/BlockLength
```

#  采用新的写法: https://relishapp.com/rspec/rspec-core/v/3-5/docs/example-groups/shared-examples

```ruby
# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
shared_examples 'concerns/locale' do
  describe "#simplified_chinese?" do
    context 'when locale is nil' do
      before do
        subject.locale = nil
      end

      it 'return true' do
        expect(subject.simplified_chinese?).to be_truthy
      end
    end
  end
end

describe User, type: :model do
  it_behaves_like 'concerns/locale'
  subject{ build(:user) }
end

# rubocop:enable Metrics/BlockLength
```

1. `shared_examples` instead of `shared_examples_for`
2. `subject` instead of `model` `instance`
