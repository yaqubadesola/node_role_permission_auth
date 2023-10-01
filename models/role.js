'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Role extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      Role.hasMany(models.User, {
        foreignKey: 'roleId',
        onDelete: 'CASCADE',
      });
      Role.belongsToMany(models.Permission, {
        through: 'RolePermission',
        as: 'userPermissions',
        foreignKey: 'roleId'
      });
    }
  }
  Role.init({
    role_name: DataTypes.STRING,
    role_description: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'Role',
  });
  return Role;
};