


from odoo import models,fields,api
import re

class ResPartner(models.Model):
    _inherit = 'res.partner'

    
    district_id = fields.Many2one('address.district', string='District')
    region_id = fields.Many2one('address.region', string='Region')
    neighbour_id = fields.Many2one('address.neighbour', string='Neighbourhood')

    @api.onchange('state_id')
    def onchange_state(self):
        if self.state_id:
            if self._origin.state_id and self._origin.state_id != self.state_id :
                
                country_id=self.env['res.country.state'].browse(self.state_id.id).country_id.id
                return {'value':{'country_id':country_id,
                            'district_id':False,
                            'region_id': False,
                            'neighbour_id': False,
                             }}
            else:
                return {}
        else:
            return {'value': {'district_id':False,
                              'region_id': False,
                              'neighbour_id': False,
                              }}

        return {}

    #TDE check Onur
    @api.onchange('neighbour_id')
    def onchange_neighbour(self):
        neighbour_obj = self.env['address.neighbour']
        if self.neighbour_id:
            neighbour_rec = neighbour_obj.browse(self.neighbour_id.id)
            return {'value': {'zip': neighbour_rec and neighbour_rec.code,
                              'region_id':neighbour_rec and neighbour_rec.region_id,
                              'district_id': neighbour_rec and neighbour_rec.region_id.district_id,
                              'state_id': neighbour_rec and neighbour_rec.region_id.district_id.state_id,
                              'country_id': neighbour_rec and neighbour_rec.region_id.district_id.state_id.country_id,
                              'city': False,
                              'neighbour_id':neighbour_rec and neighbour_rec.id,
                              }}
        return {'value': {}}
    
    
    @api.model
    def _address_fields(self):
        fields = super(ResPartner, self
                       )._address_fields()
        return fields + ['district_id','neighbour_id','region_id']

    @api.multi
    def _display_address(self,  without_company=False, context=None):

        '''
        The purpose of this function is to build and return an address formatted accordingly to the
        standards of the country where it belongs.

        :param address: browse record of the res.partner to format
        :returns: the address formatted in a display that fit its country habits (or the default ones
            if not country is specified)
        :rtype: string
        '''

        # get the information that will be injected into the display format
        # get the address format
        address_format = self.country_id.address_format or \
              "%(street)s\n%(street2)s\n%(city)s %(state_code)s %(zip)s\n%(country_name)s"
        args = {
            'state_code': self.state_id.code or '',
            'state_name': self.state_id.name or '',
            'country_code': self.country_id.code or '',
            'country_name': self.country_id.name or '',
            'company_name': self.parent_name or '',
            'neighbourhood_name': self.neighbour_id.name or '',
            'region_name': self.region_id.name or '',
            'district_name': self.district_id.name or '',
        }

        for field in self._address_fields():
            args[field] = getattr(self, field) or ''
        if without_company:
            args['company_name'] = ''
        elif self.parent_id:
            address_format = '%(company_name)s\n' + address_format
        if args['region_name']==args['district_name']:
            args['region_name']=''
        display_address = address_format % args
        display_address = re.sub('\n[\s,]*\n+', '\n', display_address.strip())
        return re.sub(r'^\s+', '', display_address,flags=re.M)


