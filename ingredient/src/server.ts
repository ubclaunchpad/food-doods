const service = require('./ingredient');
const PORT = process.env.PORT || 9000;

service.listen(PORT, () => {
    console.log(`[Ingredient] listening on port ${PORT}`);
});
