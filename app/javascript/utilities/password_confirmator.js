document.addEventListener('turbolinks:load', () => {
  let form = document.querySelector('.with-password-confirmation');
  
  if (form) {
    let [password, password_confirmation] = form.querySelectorAll('input[type="password"]');
    password.addEventListener('input', () => { confirmator(password, password_confirmation) });
    password_confirmation.addEventListener('input', () => { confirmator(password, password_confirmation) });
  }
});


function confirmator(password, password_confirmation){
  if (password_confirmation.value) {
    let status =  password.value == password_confirmation.value;
    setBorderColorTo(password, status);
    setBorderColorTo(password_confirmation, status);
  }
}

function setBorderColorTo(input_field, status) {
  let classByStatus = { true: 'border-success',
                        false: 'border-danger' }

  input_field.classList.remove(classByStatus[!status]);
  input_field.classList.add(classByStatus[status]);
}
