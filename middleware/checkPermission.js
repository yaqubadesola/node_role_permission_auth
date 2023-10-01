
const db = require('../models')
const Permission = db.Permission
const Role = db.Role;
function checkPermission(permissionName) {
  return async (req, res, next) => {
    const permissionList = req.user.permissions; // Assuming you have user information in req.user
    console.log("permissionName ", permissionName)
    const hasPermission = permissionList.length > 0 && permissionList.includes(permissionName)? true: false;
    // Check if the user has the required Role
    console.log("UserPermissons ", req.user.permissions)
    if (!hasPermission) {
      return res.status(403).json({ message: 'Forbidden - Unauthorized to perform this action' });
    }
    
    next();
  }
}
  
  module.exports = checkPermission;
  