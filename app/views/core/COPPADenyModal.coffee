ModalView = require 'views/core/ModalView'
template = require 'templates/core/coppa-deny'

forms = require 'core/forms'


module.exports = class COPPADenyModal extends ModalView
  id: 'contact-modal'
  template: template
  closeButton: true

  events:
    'click #contact-submit-button': 'contact'

