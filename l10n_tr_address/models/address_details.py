

from odoo import models, fields, api


class AddressDistrict(models.Model):
    _description = 'District'
    _name = 'address.district'

    name = fields.Char(string='District')
    state_id = fields.Many2one('res.country.state', 'State', required=True)
    
    @api.model
    def  _name_search(self, name, args=None, operator='ilike', limit=100, name_get_uid=None):
        if args is None:
            args = []
        if name:
            args += [('name', operator, name)]
        if self.env.context.get('state_id'):
            args += [('state_id', '=', self.env.context.get('state_id'))]
        ids = self.search( args, limit=limit)
        return ids.name_get()


class AddressRegion(models.Model):
    _name = 'address.region'
    _description = 'Regions'
    
    name = fields.Char(string='Region')
    district_id = fields.Many2one('address.district', 'District', required=True)
    state_id = fields.Many2one('res.country.state', 'State', related='district_id.state_id',store=True)

    @api.model
    def _name_search(self,name, args=None, operator='ilike',  limit=80):
        if args is None:
            args = []
        if name:
            args += [('name', operator, name)]
        if self.env.context.get('district_id'):
            args += [('district_id', '=', self.env.context.get('district_id'))]
        ids = self.search(args, limit=limit)
        return ids.name_get()


class AddressNeighbour(models.Model):
    _name = 'address.neighbour'
    _description = 'Neighbourhood'
    
    name = fields.Char(string='Neighbour')
    region_id = fields.Many2one('address.region', 'Region', required=True)
    code = fields.Char('Postal Code')
    state_id = fields.Many2one('res.country.state', 'State',  related='region_id.district_id.state_id')
    district_id = fields.Many2one('address.district', 'District',  related='region_id.district_id')

    @api.multi
    def name_get2(self):
        res = []
        for inst in self:
            name = inst.name or '/'
            if name and inst.district_id and inst.state_id:
                name=name+','+inst.district_id.name+','+inst.state_id.name
            res.append((inst.id, name))
        return res

    @api.model
    def name_search(self, name, args=None, operator='ilike',  limit=80):
        if args is None:
            args = []
        if name:
            if name.isdigit():
                args += [('code', operator, name)]
            else:
                args += [('name', operator, name)]
        if self.env.context.get('region_id'):
            args += [('region_id', '=', self.env.context.get('region_id'))]
        if self.env.context.get('state_id'):
            args += [('state_id', '=', self.env.context.get('state_id'))]
        ids = self.search( args, limit=limit )
        return ids.name_get2()
