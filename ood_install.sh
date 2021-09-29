# TODO: Make ood-util update form.js when form_validated.js changes
cp --remove-destination script.js form.js
cat ../../../deps/util/forms/form_validated.js >> form.js
