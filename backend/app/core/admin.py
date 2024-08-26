from django.contrib import admin  # noqa
"""
Django admin costomization.
"""
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from django.utils.translation import gettext_lazy as _

from core import models as core_models
from item import models as item_models
class UserAdmin(BaseUserAdmin):
    """Define the admin pages for users."""
    ordering = ['id']
    list_display = ['email', 'name']
    fieldsets = (
        (None,
            {'fields':('email', 'password',)}),
        (_("Permissions"),
            {'fields':('is_active', 'is_staff', 'is_superuser',)}),
        (_("Important dates"),
            {'fields':('last_login',)})
    )
    readonly_fields = ['last_login']
    add_fieldsets = (
        (None, {
            'classes':('wide',),
            'fields': (
                'email',
                'password1',
                'password2',
                'name',
                'is_active',
                'is_staff',
                'is_superuser',
            ),
        }),
    )

admin.site.register(core_models.User, UserAdmin)
admin.site.register(item_models.Item)
admin.site.register(item_models.Brand)
admin.site.register(item_models.Category)

