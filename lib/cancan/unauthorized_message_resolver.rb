module CanCan
  module UnauthorizedMessageResolver
    def unauthorized_message(action, subject)
      keys = unauthorized_message_keys(action, subject)
      variables = { action: action.to_s }
      variables[:subject] = translate_subject(subject)
      message = I18n.translate(keys.shift, variables.merge(scope: :unauthorized, default: keys + ['']))
      message.blank? ? nil : message
    end

    def translate_subject(subject)
      klass = (subject.class == Class ? subject : subject.class)
      if klass.respond_to?(:model_name)
        klass.model_name.human
      else
        klass.to_s.underscore.humanize.downcase
      end
    end
  end
end
