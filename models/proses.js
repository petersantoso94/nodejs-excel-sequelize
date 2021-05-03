'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class proses extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  };
  proses.associate = function(models) {
    proses.hasMany(models.output, {
        foreignKey: {
          name: 'Proses_id',
          allowNull: false
        },
        as : "output"
      })
    proses.hasMany(models.input, {
        foreignKey: {
          name: 'Proses_id',
          allowNull: false
        },
        as : "input"
      })
  };
  proses.init({
  }, {
    sequelize,
    modelName: 'proses',
    timestamps: false
  });
  return proses;
};