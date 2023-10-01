'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class User extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      //console.log("I got called in User")
      //User.hasMany(models.Post);
      User.hasMany(models.Post, {
        foreignKey: 'userId', // Name of the foreign key column in the Posts table
        onDelete: 'CASCADE',  // Optional: Cascade deletes
        as: 'AuthoredPosts' 
      });// This establishes a one-to-many relationship
      //Source Model holds the foreign key
      User.belongsTo(models.Role, {
        foreignKey: 'roleId',
        onDelete: 'CASCADE',
      });
    }
  }
  User.init({
    name: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
    },
    email: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true,
    },
    password: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    refreshToken: {
      type: DataTypes.STRING,
    }
  }, {
    sequelize,
    modelName: 'User',
    hooks: {
      beforeValidate: (user, options) => {
        if (!user.name || user.name.length < 3) {
          throw new Error('name must be at least 3 characters long.');
        }

        if (!user.email || !user.email.includes('@')) {
          throw new Error('Invalid email format.');
        }
      },
    },
  });
  return User;
};