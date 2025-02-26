package pl.dmcs.validator;

import org.apache.commons.validator.routines.EmailValidator;
import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;
import pl.dmcs.domain.AppUser;

public class RegisterValidator implements Validator {

    EmailValidator emailValidator = EmailValidator.getInstance();

    @Override
    public boolean supports(Class clazz) {
        return AppUser.class.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object arg0, Errors errors) {
        ValidationUtils.rejectIfEmpty(errors, "email", "error.field.required");
        ValidationUtils.rejectIfEmpty(errors, "password", "error.field.required");
        if (errors.getErrorCount() == 0) {
            if (StringUtils.hasText(((AppUser)arg0).getEmail()) && emailValidator.isValid(((AppUser)arg0).getEmail()) == false) {
                errors.rejectValue("email", "error.email.invalid");
            }
        }
    }
}
